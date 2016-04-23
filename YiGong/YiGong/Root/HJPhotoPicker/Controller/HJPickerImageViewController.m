//
//  HJPickerImageViewController.m
//  HJPhotoPikerDemo
//
//  Created by 黄靖 on 16/3/26.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPickerImageViewController.h"
#import "HJInputView.h"
#import "HJTableViewCell.h"
#import "HJPhotoPickerView.h"
#import "HJEditImageViewController.h"
#define UPLOADFILE_URL @"vaiadd"
#define IMAGE_SIZE (SCREEN_WIDTH - 60)/4

@interface HJPickerImageViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>

/** 文本输入框*/
@property(nonatomic, strong)    HJInputView *inputV;
/** UITableView*/
@property(nonatomic, strong)    UITableView *tabelV;
/** 选择图片*/
@property(nonatomic, strong)    HJPhotoPickerView *photoPickerV;
/** 图片编辑起*/
@property(nonatomic, strong)    HJEditImageViewController *editVC;
/** 当前选择的图片*/
@property(nonatomic, strong)    NSMutableArray *imageDataSource;
@end

@implementation HJPickerImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

/**
 *  上传图片
 */
- (void)uploadImage{
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,UPLOADFILE_URL];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObject:self.activityId forKey:@"vaid"];
    for (int i = 0 ; i < _imageDataSource.count - 1; i ++) {
        NSData * imageData = UIImageJPEGRepresentation(_imageDataSource[i], 0.1);
        [dic setValue:imageData forKey:[NSString stringWithFormat:@"file%d",i]];
    }
    [tool showLoadingHudWithTitle:@"正在上传..." OnView:self.view];
    NSMutableArray * images = [NSMutableArray arrayWithArray:_imageDataSource];
    [images removeLastObject];
    [tool postFileWithUrl:url file:images parameters:dic success:^(id responseObject) {
        [tool.hud hide:YES];
        [self showHudWithText:@"上传成功！"];
        HJLog(@"上传成功！");
    } fail:^(NSError *error) {
        [self showHudWithText:@"上传失败"];
        HJLog(@"%@",error);
    }];
}


/**
 *  完成选择
 *
 *  @return 返回选中的图片
 */
- (void)completeChoose{
    self.getImagesBlock(_imageDataSource);
    [self.navigationController popViewControllerAnimated:YES];
}

// 为图片添加点击事件
- (void)addTargetForImage{
    for (UIButton * button in _photoPickerV.imageViews) {
        [button addTarget:self action:@selector(addPhotos:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    //不自动调整滚动视图的预留空间
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (_isTeamCer) {
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeChoose)];
        
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"上传" style:UIBarButtonItemStyleDone target:self action:@selector(uploadImage)];
    }
    
    //    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    //    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName,nil]];
    // 初始化输入视图
    _inputV = [[HJInputView alloc]init];
    _inputV.textV.delegate = self;
    _inputV.placeholerLabel.text = _imageTitle;
    _inputV.textV.editable = NO;
    
    // 图片选择视图
    _photoPickerV = [[HJPhotoPickerView alloc]init];
    _photoPickerV.frame = CGRectMake(0, _inputV.frame.size.height +10, SCREEN_WIDTH, IMAGE_SIZE);
    _photoPickerV.reloadTableViewBlock = ^{
        [weakSelf.tabelV reloadData];
    };
    [self addTargetForImage];
    
    // 初始化图片数组
    _imageDataSource = [NSMutableArray array];
    [_imageDataSource addObject:_photoPickerV.addImage];
    
    // 初始化图片编辑控制器
    self.editVC = [[HJEditImageViewController alloc]init];
    
    
    _tabelV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tabelV.delegate = self;
    _tabelV.dataSource = self;
    [self.view addSubview:_tabelV];
    
}

/**
 *  选择图片
 */

- (void)addPhotos:(UIButton *)button{
    
    __weak typeof(self) weakSelf = self;
    
    if ([button.currentBackgroundImage isEqual:_photoPickerV.addImage]) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:10 - _imageDataSource.count delegate:self];
        // You can get the photos by block, the same as by delegate.
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
            [_imageDataSource removeLastObject];
            [_imageDataSource addObjectsFromArray:photos];
            [_imageDataSource addObject:_photoPickerV.addImage];
            [self.photoPickerV setSelectedImages:_imageDataSource];
            [self addTargetForImage];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }else{
        _editVC = [[HJEditImageViewController alloc]init];
        _editVC.currentOffset = (int)button.tag;
        _editVC.reloadBlock = ^(NSMutableArray * images){
            [weakSelf.photoPickerV setSelectedImages:images];
            [weakSelf addTargetForImage];
        };
        _editVC.images = _imageDataSource;
        [self.navigationController pushViewController:_editVC animated:YES];
    }
}


#pragma mark --------------UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length) {
        [_inputV.placeholerLabel removeFromSuperview];
    }else{
        [_inputV.textV addSubview:_inputV.placeholerLabel];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJTableViewCell";
    
    HJTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        
        cell = [[HJTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    [cell addSubview:_inputV];
    [cell addSubview:_photoPickerV];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowHeight = _photoPickerV.frame.size.height + _photoPickerV.frame.origin.y + 10;
    if (!indexPath.row) return rowHeight;
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.0001f;
}

#pragma mark --------------UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tabelV deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark --------------SystemVCDelegate
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_inputV.textV resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

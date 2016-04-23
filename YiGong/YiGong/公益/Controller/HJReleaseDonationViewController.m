//
//  HJRleaseDonationViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJReleaseDonationViewController.h"
#import "HJReleaseDonationTableViewCell.h"
#import "HJReleaseModel.h"
#import "HJInputView.h"
#import "HJPhotoPickerView.h"
#import "HJEditImageViewController.h"
#define ADD_DONATION_URL @"vdadd"

@interface HJRleaseDonationViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    MBProgressHUD * hud;
    NSString * title;
    NSString * target;
    HJReleaseDonationTableViewCell * currentCell;
}
/** 文本输入框*/
@property(nonatomic, strong)    HJInputView *inputV;
/** 选择图片*/
@property(nonatomic, strong)    HJPhotoPickerView *photoPickerV;
/** 图片编辑起*/
@property(nonatomic, strong)    HJEditImageViewController *editVC;
/** 当前选择的图片*/
@property(nonatomic, strong)    NSMutableArray *imageDataSource;
/** UITableView*/
@property(nonatomic, strong)    UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong)    NSMutableArray *dataSource;

@end
#define IMAGE_SIZE (SCREEN_WIDTH - 60)/4
@implementation HJRleaseDonationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}
- (void)createValue{
    _dataSource = [NSMutableArray array];
    NSArray * titles = @[@"标题",@"捐赠对象"];
    NSArray * placeholders = @[@"老北京 布鞋50双库存捐赠",@"60岁以上老人或福利院"];
    for (int i = 0; i < titles.count; i ++) {
        HJReleaseModel * model = [[HJReleaseModel alloc]init];
        model.title = titles[i];
        model.content = placeholders[i];
        [_dataSource addObject:model];
    }
}

// 为图片添加点击事件
- (void)addTargetForImage{
    for (UIButton * button in _photoPickerV.imageViews) {
        [button addTarget:self action:@selector(addPhotos:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)createUI{

    __weak typeof(self) weakSelf = self;
    //不自动调整滚动视图的预留空间
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 初始化输入视图
    _inputV = [[HJInputView alloc]init];
    _inputV.textV.delegate = self;
    _inputV.placeholerLabel.text = self.placeholder;
   
    
    // 图片选择视图
    _photoPickerV = [[HJPhotoPickerView alloc]init];
    _photoPickerV.frame = CGRectMake(0, _inputV.frame.size.height +10, SCREEN_WIDTH, IMAGE_SIZE);
    _photoPickerV.reloadTableViewBlock = ^{
        [weakSelf.tableV reloadData];
    };
    [self addTargetForImage];
    
    // 初始化图片数组
    _imageDataSource = [NSMutableArray array];
    [_imageDataSource addObject:_photoPickerV.addImage];
    
    // 初始化图片编辑控制器
    self.editVC = [[HJEditImageViewController alloc]init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
}

// 添加图片
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!section) return _dataSource.count; return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJReleaseDonationTableViewCell";
    HJReleaseDonationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJReleaseDonationTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"123"];
        cell.indexPath = indexPath;
        
    }
    if (!indexPath.section)
    {
        cell.model = _dataSource[indexPath.row];
        [cell setGetCurrentBlock:^{
            if (indexPath.row) {
                target = cell.textF.text;
            }else{
                title = cell.textF.text;
            }
            HJLog(@"%@",title);
        }];
        
    }else{
        [cell addSubview:_inputV];
        [cell addSubview:_photoPickerV];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowHeight = _photoPickerV.frame.size.height + _photoPickerV.frame.origin.y + 10;
    if (indexPath.section) return rowHeight;
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section) return 80;
    return 18;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    if (section) {
        UIButton * publisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        publisBtn.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 40);
        [publisBtn setBackgroundImage:[UIImage imageWithColor:HJRGBA(248, 97, 111, 1.0)] forState:UIControlStateNormal];
        [publisBtn setTitle:@"发布" forState:UIControlStateNormal];
        [publisBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [publisBtn addTarget:self action:@selector(publishAction:) forControlEvents:UIControlEventTouchUpInside];
        publisBtn.layer.cornerRadius = 5;
        publisBtn.clipsToBounds = YES;
        [view addSubview:publisBtn];
        return view;
    }
    return [[UIView alloc]init];
}

#pragma mark --------------ClickAction
- (void)publishAction:(UIButton *)button{
    /**
     *  上传图片
     */
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,ADD_DONATION_URL];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    if (title && target && _inputV.textV.text) {
        [dic setObject:title forKey:@"title"];
        [dic setObject:target forKey:@"target"];
        [dic setObject:_inputV.textV.text forKey:@"content"];
    }else{
        [self createAlertControllerWithTitle:@"捐赠信息不能为空"];
    }
    
    [_imageDataSource removeLastObject];
    for (int i = 0 ; i < _imageDataSource.count ; i ++) {
        NSData * imageData = UIImageJPEGRepresentation(_imageDataSource[i], 1.0);
        [dic setValue:imageData forKey:[NSString stringWithFormat:@"file%d",i]];
    }
    [self showHUD];
    [tool postFileWithUrl:url file:_imageDataSource parameters:dic success:^(id responseObject) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"上传成功！";
        [hud hide:YES afterDelay:1];
        HJLog(@"上传成功！");
    } fail:^(NSError *error) {
        HJLog(@"%@",error);
    }];
    
}
- (void)createAlertControllerWithTitle:(NSString *)topic{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:topic message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:^{
       
    }];
}
- (void)showHUD{
    hud = [[MBProgressHUD alloc]init];
    hud.labelText = @"正在发布";
    [self.view addSubview:hud];
    [hud show: YES];
}
@end

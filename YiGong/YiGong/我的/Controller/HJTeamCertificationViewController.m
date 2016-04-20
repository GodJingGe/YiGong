//
//  HJTeamCertificationViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/9.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTeamCertificationViewController.h"
#import "HJCetificationTableViewCell.h"
#import "HJPickerImageViewController.h"
#import "HJFooterView.h"
#define CERTIFICATION_URL @"vtadd"

@interface HJTeamCertificationViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 审核信息*/
@property(nonatomic, strong) NSMutableDictionary *parameters;
/** 当前编辑的cell*/
@property(nonatomic, strong) HJCetificationTableViewCell *currentCell;
/** AlertVC*/
@property(nonatomic, strong) UIAlertController * alertVC;
@end

@implementation HJTeamCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}
- (void)createValue{
    _model = [[HJCertificationModel alloc]init];
    _dataSource = [NSMutableArray array];
    NSArray * keys = @[@"name",@"htime",@"address",@"describe",@"userid"];
    NSArray * objects = @[@"",@"",@"",@"",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]];
    _parameters = [NSMutableDictionary dictionary];
    for (int i = 0; i < keys.count; i ++) {
        [_parameters setObject:objects[i] forKey:keys[i]];
    }
    
    NSArray * titles = @[@"团体logo",@"团体名称",@"成立时间",@"通讯地址",@"团队描述",@"团体证照"];
    [_dataSource addObjectsFromArray:titles];
}
- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 60;
    [self.view addSubview:self.tableV];
    
    
}
- (void)createAlertWithTitle:(NSString *)title{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"认证信息不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJCetificationTableViewCell";
    HJCetificationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJCetificationTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        cell.indexPath = indexPath;
    }
    cell.titleLabel.text = _dataSource[indexPath.row];
    if (indexPath.row == 0||indexPath.row == 5) {
        [cell addSubview:cell.logoImageV];
    }else{
        [cell addSubview:cell.detailLabel];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    HJFooterView * footer = [[HJFooterView alloc]initWithAction:^{
        HJRequestTool * tool = [[HJRequestTool alloc]init];
        NSString * url = [NSString stringWithFormat:COMMON_URL,CERTIFICATION_URL];
        if (!_model.logoImage||!_model.teamName.length||!_model.setUpTime.length||!_model.address.length||!_model.teamDesc.length||!_model.images.count) {
            [self createAlertWithTitle:@"认证信息不能为空"];
            HJLog(@"%@",_model);
            return ;
        }
        // 添加图片
        for (int i = 0; i < _model.images.count ;i ++) {
            UIImage * image = _model.images[i];
            NSData * data = UIImageJPEGRepresentation(image, 0.1);
            [_parameters setObject:data forKey:[NSString stringWithFormat:@"file%d",i + 1]];
        }
        [_model.images insertObject:_model.logoImage atIndex:0];
        HJLog(@"%@",_parameters);
        [tool postFileWithUrl:url file:_model.images parameters:_parameters success:^(id responseObject) {
            NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            [self showHudWithText:jsonData[@"info"]];
            HJLog(@"%@",jsonData);
        } fail:^(NSError *error) {
            
        }];
        [tool postJSONWithUrl:url parameters:_parameters success:^(id responseObject) {
            
        } fail:^(NSError *error) {
            
        }];
    }];
    
    [footer.footerBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    footer.frame = CGRectMake(0, SCREEN_HEIGHT - 100 - 64, SCREEN_WIDTH, 80);
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    _currentCell = [tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            [self chooseImageFromImagePickerController];
        }
            break;
            
        case 1:
        {
            [self changeInfoWithTitle:@"团体名称"];
        }
            break;
        case 2:
        {
    
            _datePickerView = [[HJDatePickerView alloc]initAndGetTime:^(NSString *timeDate) {
                _currentCell.detailLabel.text = timeDate;
                _model.setUpTime = timeDate;
                [_parameters setObject:_model.setUpTime forKey:@"htime"];
                
            }];
        }
            break;
        case 3:{
            [self changeInfoWithTitle:@"通讯地址"];
        }
            break;
        case 4:
        {
            [self changeInfoWithTitle:@"团体描述"];
        }
            break;
        case 5:
        {
            HJPickerImageViewController * pickerVC = [[HJPickerImageViewController alloc]init];
            pickerVC.isTeamCer = YES;
            pickerVC.title = @"证件照选择";
            [pickerVC setGetImagesBlock:^(NSMutableArray *images) {
                _currentCell.logoImageV.image = images[0];
                _model.images = images;
            }];
            [self.navigationController pushViewController:pickerVC animated:YES];
        }
            
            break;
    }
}

- (void)changeInfoWithTitle:(NSString *)title{
    __weak typeof(self)weakSelf = self;
    _alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [_alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardAppearanceDefault;

        textField.placeholder = weakSelf.currentCell.detailLabel.text;
    }];
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (_alertVC.textFields[0].text.length)
        _currentCell.detailLabel.text = _alertVC.textFields[0].text;
        switch (_currentCell.indexPath.row) {
            case 1:
            {
                _model.teamName = _alertVC.textFields[0].text;
                [_parameters setObject:_model.teamName forKey:@"name"];
                break;
            }
            case 3:
            {
                _model.address = _alertVC.textFields[0].text;
                [_parameters setObject:_model.address forKey:@"address"];
            }
                break;
            case 4:
            {
                _model.teamDesc = _alertVC.textFields[0].text;
                [_parameters setObject:_model.teamDesc forKey:@"describe"];
            }
                break;
        }
        
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [_alertVC addAction:cancelAction];
    [_alertVC addAction:okAction];
    
    [self presentViewController:_alertVC animated:YES completion:nil];
}
//设置头像
- (void)chooseImageFromImagePickerController{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    UIAlertAction * chooseAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
    }];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    
    [alertVC addAction:cancelAction];
    [alertVC addAction:chooseAction];
    [alertVC addAction:cameraAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];

    _currentCell.logoImageV.image = image;
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
    _model.logoImage = image;
    [_parameters setObject:data forKey:@"file0"];
    HJLog(@"%@",_model.logoImage);
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 设置导航栏透明
- (void)setNavigationBarStyleClear{
    
    UIColor * color = [UIColor clearColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.navigationController.navigationBar.translucent = YES;
    
}

// 设置导航栏正常
- (void)setNavigationBarStyleNormal{
    
    UIColor * color = THEME_COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self ScreenShot];
    [self setNavigationBarStyleClear];
}

@end

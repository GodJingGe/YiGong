//
//  HJPersonalInfoViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPersonalInfoViewController.h"
#import "HJPersonalTableViewCell.h"
#import "HJPersonalModel.h"
#import "HJDatePickerView.h"
#import "HJFooterView.h"
#define USER_INFO

@interface HJPersonalInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 当前编辑的cell*/
@property(nonatomic, strong) HJPersonalTableViewCell *currentCell;
/** 时间选择器*/
@property(nonatomic, strong) HJDatePickerView *datePicker;
/** alertActionSheet*/
@property(nonatomic, strong) UIAlertController * alertVC;
/** alertInput*/
@property(nonatomic, strong) UIAlertController * inputAlertVC;
/** 个人模型数据*/
@property(nonatomic, strong) NSMutableDictionary *parameters;

@end

@implementation HJPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self createUI];
}
- (void)createUI{
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 60;
    [self.view addSubview:self.tableV];
    
}
- (void)loadData{
    _parameters = [self.model mj_keyValues];
    _dataSource = [NSMutableArray array];
    NSArray * titles = @[@"头像",@"昵称",@"性别",@"出生年月",@"手机号码",@"通讯地址",@"从事工作",@"个性签名"];
    [_dataSource addObjectsFromArray:titles];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJPersonalTableViewCell";
    HJPersonalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJPersonalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        
    }
    cell.titleLabel.text = _dataSource[indexPath.row];
    cell.indexPath = indexPath;
    cell.model = self.model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)  return 0.0001f;
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

// 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    _currentCell = [tableView cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:{
            
            [self chooseImageFromImagePickerController];
            
        }
            break;
            
        case 1:{
            [self changeInfoWithTitle:@"昵称"];
        }
            
            break;
            
        case 2:{
            [self createAlertControllerWithTitles:@[@"男",@"女"]];
        }
            break;
        case 3:{
            _datePicker = [[HJDatePickerView alloc]initAndGetTime:^(NSString *timeDate) {
                _currentCell.detailLabel.text = [[timeDate componentsSeparatedByString:@" "] firstObject];
                _model.birthday = _currentCell.detailLabel.text;
                [_parameters setObject:_currentCell.detailLabel.text forKey:@"BIRTH"];
            }];
            _datePicker.datePicker.datePickerMode = UIDatePickerModeDate;
        }
            break;
        case 4:{
            [self changeInfoWithTitle:@"手机号码"];
        }
            break;
        case 5:{
            [self changeInfoWithTitle:@"通讯地址"];
        }
            break;
        case 6:{
            [self changeInfoWithTitle:@"从事工作"];
        }
            break;
        case 7:{
            [self changeInfoWithTitle:@"个性签名"];
        }
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    HJFooterView * footer = [[HJFooterView alloc]initWithAction:^{
        HJLog(@"保存信息");
    }];
    [footer.footerBtn setTitle:@"保存" forState:UIControlStateNormal];
    return footer;
}

//设置头像
- (void)chooseImageFromImagePickerController{
    _alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
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
    
    [_alertVC addAction:cancelAction];
    [_alertVC addAction:chooseAction];
    [_alertVC addAction:cameraAction];
    
    [self presentViewController:_alertVC animated:YES completion:nil];
}

// 设置信息
- (void)changeInfoWithTitle:(NSString *)title{
    
    _inputAlertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    [_inputAlertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardAppearanceDefault;
        
        textField.placeholder = weakSelf.currentCell.detailLabel.text;
    }];
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (_inputAlertVC.textFields[0].text.length){
            _currentCell.detailLabel.text = _inputAlertVC.textFields[0].text;
            switch (_currentCell.indexPath.row) {
                case 1:
                    [_parameters setObject:_currentCell.detailLabel.text forKey:@"USERNAME"];
                    break;
                    
                case 4:
                    [_parameters setObject:_currentCell.detailLabel.text forKey:@"PHONE"];
                    break;
                    
                case 5:
                    [_parameters setObject:_currentCell.detailLabel.text forKey:@"ADDRESS"];
                    break;
                    
                case 6:
                    [_parameters setObject:_currentCell.detailLabel.text forKey:@"JOB"];
                    break;
                    
                case 7:
                    [_parameters setObject:_currentCell.detailLabel.text forKey:@"SIGN"];
                    break;
            }
        }
        
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [_inputAlertVC addAction:cancelAction];
    [_inputAlertVC addAction:okAction];
    
    [self presentViewController:_inputAlertVC animated:YES completion:nil];
}

- (void)createAlertControllerWithTitles:(NSArray *)titles{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString * title in titles) {
        UIAlertAction * action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_parameters setObject:title forKey:@"GENDER"];
            _currentCell.detailLabel.text = title;
        }];
        [alertVC addAction:action];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
}

// 相机相册获取回调代理
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    _currentCell.iconImageView.image = image;
    _model.newavatar = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

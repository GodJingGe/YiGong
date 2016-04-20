//
//  HJPubActivityViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPubActivityViewController.h"
#import "HJPubActivityTableViewCell.h"
#import "HJActivityModel.h"
#import "HJDatePickerView.h"
#import "HJFooterView.h"
#import "HJScheduleModel.h"
#import "HJAddScheduleViewController.h"
#import "HJAreaPickerView.h"
#define PUBACT_URL @"vaadd"

@interface HJPubActivityViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 当前编辑的cell*/
@property(nonatomic, strong) HJPubActivityTableViewCell *currentCell;
/** 模型*/
@property(nonatomic, strong) HJActivityModel *model;
/** 时间选择器*/
@property(nonatomic, strong) HJDatePickerView *datePicker;
/** 城市选择器*/
@property(nonatomic, strong) HJAreaPickerView *areaPicker;
/** alertActionSheet*/
@property(nonatomic, strong) UIAlertController * alertVC;
/** alertInput*/
@property(nonatomic, strong) UIAlertController * inputAlertVC;

@end

@implementation HJPubActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self createUI];
}
- (void)createUI{
    
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 60;
    [self.view addSubview:self.tableV];
}
- (void)loadData{
    _dataSource = [NSMutableArray array];
    _model = [[HJActivityModel alloc]init];
    NSArray * titles = @[@"主题图片",@"活动主题",@"活动城市",@"活动地址",@"活动时间",@"结束时间",@"参加人数",@"活动介绍",@"日程安排"];
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
    static NSString * reuseID = @"HJPubActivityTableViewCell";
    HJPubActivityTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HJPubActivityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.indexPath = indexPath;
        cell.titleLabel.text = _dataSource[indexPath.row];
    }
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    _currentCell = [tableView cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:{
            
            [self chooseImageFromImagePickerController];
            
        }
            break;
            
        case 1:{
            [self changeInfoWithTitle:@"活动主题"];
        }
            
            break;
            
        case 2:{
            _areaPicker = [[HJAreaPickerView alloc]initWithArea:^(NSString *province, NSString *city) {
                _model.city = city;
                _currentCell.detailLabel.text = _model.city;
            }];
        }
            break;
        case 3:{
            [self changeInfoWithTitle:@"活动地址"];
        }
            
            break;
        case 4:{
            _datePicker = [[HJDatePickerView alloc]initAndGetTime:^(NSString *timeDate) {
                _currentCell.detailLabel.text = timeDate;
                _model.startTime = timeDate;
            }];
        }
            break;
        case 5:{
            _datePicker = [[HJDatePickerView alloc]initAndGetTime:^(NSString *timeDate) {
                _currentCell.detailLabel.text = timeDate;
                _model.endTime = timeDate;
            }];
        }
            break;
        case 6:{
            [self changeInfoWithTitle:@"参加人数"];
        }
            break;
        case 7:{
            [self changeInfoWithTitle:@"活动介绍"];
        }
            break;
        case 8:{
            HJAddScheduleViewController * addScheduleVC = [[HJAddScheduleViewController alloc]init];
            addScheduleVC.title = @"添加日程";
            [addScheduleVC setCompleteAdd:^(NSMutableArray <HJScheduleModel *>*schedules) {
                
                _model.agenda = [self getFormmatContent:schedules];
                _currentCell.detailLabel.text = _model.agenda;

            }];
            [self.navigationController pushViewController:addScheduleVC animated:YES];
        }
            break;
    }
}
- (NSString *)getFormmatContent:(NSArray *)contents{
    NSString * content = @"";
    for (HJScheduleModel * model in contents) {
        HJLog(@"%@ %@",model.dateTime,model.content);
        NSString * schedule = [NSString stringWithFormat:@"%@ %@",model.dateTime,model.content];
        content = [content stringByAppendingFormat:@"%@\n",schedule];
    }
    return content;

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    HJFooterView * footer = [[HJFooterView alloc]initWithAction:^{
        
        _model.sponsor = [[NSUserDefaults standardUserDefaults] valueForKey:@"vtid"];
        
        NSMutableDictionary * para = [NSMutableDictionary dictionaryWithObject:_model.sponsor forKey:@"vtid"];
        [para setObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
        if (_model.themeImage && _model.city &&_model.title.length && _model.startTime.length && _model.endTime.length && _model.address.length && _model.personNum.length && _model.desc.length && _model.agenda.length) {
            NSData * data = UIImageJPEGRepresentation(_model.themeImage, 0.1);
            [para setObject:data forKey:@"file0"];
            [para setObject:_model.title forKey:@"topic"];
            [para setObject:_model.city forKey:@"city"];
            [para setObject:_model.startTime forKey:@"stime"];
            [para setObject:_model.endTime forKey:@"etime"];
            [para setObject:_model.address forKey:@"address"];
            [para setObject:_model.desc forKey:@"content"];
            [para setObject:_model.personNum forKey:@"limit"];
            [para setObject:_model.agenda forKey:@"schedule"];
        }else{
            [self createAlertWithTitle:@"活动信息不能为空"];
        }
        HJLog(@"%@",para);
        NSString * url = [NSString stringWithFormat:COMMON_URL,PUBACT_URL];
        HJRequestTool * tool = [[HJRequestTool alloc]init];
        NSMutableArray * images = [NSMutableArray array];
        [images addObject:_model.themeImage];
        
        [tool postFileWithUrl:url file:images parameters:para success:^(id responseObject) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            HJLog(@"%@",dic);
            if ([dic[@"result"] isEqualToString:@"01"]) {
                [self showHudWithText:@"发布成功！"];
            }
        } fail:^(NSError *error) {
            
        }];
        
    }];
    [footer.footerBtn setTitle:@"发布" forState:UIControlStateNormal];
    return footer;
}
- (void)createAlertWithTitle:(NSString *)title{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"认证信息不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:YES completion:nil];
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
        
        if (_inputAlertVC.textFields[0].text.length)
        {
            _currentCell.detailLabel.text = _inputAlertVC.textFields[0].text;
            switch (_currentCell.indexPath.row) {
                case 1:
                    _model.title = _currentCell.detailLabel.text;
                    break;
                case 3:
                    _model.address = _currentCell.detailLabel.text;
                    break;
                case 6:
                    _model.personNum = _currentCell.detailLabel.text;
                    break;
                case 7:
                    _model.desc = _currentCell.detailLabel.text;
                    break;
            }
        }
        HJLog(@"%@",_inputAlertVC.textFields[0].text);
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [_inputAlertVC addAction:cancelAction];
    [_inputAlertVC addAction:okAction];
    
    [self presentViewController:_inputAlertVC animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    _currentCell.iconImageView.image = image;
    _model.themeImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

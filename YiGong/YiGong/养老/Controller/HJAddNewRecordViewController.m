//
//  HJAddNewRecordViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJAddNewRecordViewController.h"
#import "HJHealthCareTableViewCell.h"
#import "HJFooterView.h"
#define NEWRECORD_URL @"gmhadd"

@interface HJAddNewRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 数据源*/
@property(nonatomic, strong)NSMutableArray *dataSource;
/** 列表*/
@property(nonatomic, strong)UITableView *tableV;
/** 当前cell*/
@property(nonatomic, strong) HJHealthCareTableViewCell *currentCell;
/** 当前记录*/
@property(nonatomic, strong) NSMutableArray *currentValue;

@end



@implementation HJAddNewRecordViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}

- (void)createValue{
    _currentValue = [NSMutableArray arrayWithObjects:@"11;0",@"12;0",@"13;0",@"14;0",@"15;0",@"16;0", nil];
    NSArray * arr = @[@"体温",@"脉搏",@"呼吸",@"血压",@"血氧",@"血糖"];
    _dataSource = [NSMutableArray array];
    [_dataSource addObjectsFromArray:arr];
}

- (void)createUI{
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 );
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableV addGestureRecognizer:gestureRecognizer];
    
    //ps:加上这句不会影响你 tableview 上的 action (button,cell selected...)
    gestureRecognizer.cancelsTouchesInView = NO;
    
    
}
- (void)hideKeyboard{
    
    [self.currentCell.textF resignFirstResponder];
    
}


#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJHealthCareTableViewCell";
    HJHealthCareTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJHealthCareTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.indexPath = indexPath;
        cell.titleLabel.text = _dataSource[indexPath.row];
        [cell addSubview:cell.textF];
        
        __weak typeof(self) weakSelf = self;
        [cell setGetCurrentCellBlock:^(HJHealthCareTableViewCell *currentCell) {
            // 获取当前的cell
            weakSelf.currentCell = currentCell;
        }];
        
        // 获取当前键盘的值
        [cell setGetCurrentValueBlock:^(HJHealthCareTableViewCell *currentCell) {
            NSString * value = [NSString stringWithFormat:@"%ld;%@",currentCell.indexPath.row + 11,currentCell.textF.text];
            [weakSelf.currentValue replaceObjectAtIndex:currentCell.indexPath.row withObject:value];
            HJLog(@"%@",_currentValue);
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)  return 0.0001f;
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    HJFooterView * footer = [[HJFooterView alloc]initWithAction:^{
        [self saveInfo];
    }];

    [footer.footerBtn setTitle:@"保存" forState:UIControlStateNormal];
    return footer;
}

- (void)saveInfo{
    
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,NEWRECORD_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    if ([_currentValue[3] containsString:@"/"]) {
        NSArray * arr = [_currentValue[3] componentsSeparatedByString:@";"];
        NSString * str = arr[1];
        NSArray * arr1 = [str componentsSeparatedByString:@"/"];
        if ([arr1[0] intValue] < [arr1[1] intValue]) {
            [_currentValue replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@;%@/%@",arr[0],arr1[1],arr1[0]]];
        }
    }
    NSString * value = [_currentValue componentsJoinedByString:@","];
    [dic setValue:value forKey:@"value"];
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([jsonData[@"result"] isEqualToString:@"01"]) {
            [self showHudWithText:@"保存成功"];
        }
    } fail:^(NSError *error) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}



@end

//
//  HJAddNewRecordViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJAddNewRecordViewController.h"
#import "HJHealthCareTableViewCell.h"

@interface HJAddNewRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 数据源*/
@property(nonatomic, strong)NSMutableArray *dataSource;
/** 列表*/
@property(nonatomic, strong)UITableView *tableV;

@end

@implementation HJAddNewRecordViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}

- (void)createValue{
    NSArray * arr = @[@"体温",@"脉搏",@"呼吸",@"血压",@"血氧",@"血糖"];
    _dataSource = [NSMutableArray array];
    [_dataSource addObjectsFromArray:arr];
}

- (void)createUI{
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
}
- (void)loadData{
    
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
        cell.titleLabel.text = _dataSource[indexPath.row];
        [cell addSubview:cell.textF];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)  return 0.0001f;
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}



@end

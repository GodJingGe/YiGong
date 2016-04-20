//
//  HJHealthManagerViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJHealthManagerViewController.h"
#import "HJHealthCareTableViewCell.h"
#import "HJHealthRecordViewController.h"

@interface HJHealthManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
@end

@implementation HJHealthManagerViewController

- (void)viewDidLoad {
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HJHealthRecordViewController * healthRecordVC = [[HJHealthRecordViewController alloc]init];
    healthRecordVC.title = [NSString stringWithFormat:@"%@记录",_dataSource[indexPath.row]];
    healthRecordVC.type = [NSString stringWithFormat:@"%ld",indexPath.row + 11];
    [self.navigationController pushViewController:healthRecordVC animated:YES];
}

@end

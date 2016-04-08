//
//  HJCMWTeamViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJCMWTeamViewController.h"
#import "HJTeamModel.h"
#import "HJTeamTableViewCell.h"
#import "HJTeamCenterViewController.h"
@interface HJCMWTeamViewController ()<UITableViewDelegate,UITableViewDataSource>
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HJCMWTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self viewConfig];
}
- (void)createValue{
    _dataSource = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        HJTeamModel * model = [[HJTeamModel alloc]init];
        model.teamIcon = [NSString stringWithFormat:@"team_img%02d",i+1];
        [_dataSource addObject:model];
    }
}
- (void)viewConfig{
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 90;
    [self.view addSubview:self.tableV];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJPartakeTableViewCell";
    HJTeamTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJTeamTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        cell.indexPath = indexPath;
        cell.model = _dataSource[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HJTeamCenterViewController * teamCenterVC = [[HJTeamCenterViewController alloc]init];
    [self.navigationController pushViewController:teamCenterVC animated:YES];
}

@end

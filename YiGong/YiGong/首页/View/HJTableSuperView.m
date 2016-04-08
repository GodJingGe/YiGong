//
//  HJTableSuperView.m
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTableSuperView.h"

@implementation HJTableSuperView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{

    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    self.frame = rect;
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    
    // 添加下拉刷新和上拉加载视图
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(_isRefreshing) return;
        
        _isRefreshing = YES;
        [self loadData];
        _isRefreshing = NO;
        [_tableV.mj_header endRefreshing];
    }];
    
    self.tableV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if(_isLoading) return;
        
        _isLoading = YES;
        [self loadData];
        _isLoading = NO;
        [_tableV.mj_footer endRefreshing];
    }];
    [self addSubview:self.tableV];
    
}
- (void)loadData{
    
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJMainTableViewCell";
    _cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!_cell) {
        _cell = [[HJMainTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        _model = [[HJMainModel alloc]init];
        _cell.model = _model;
    }
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 304;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HJCMWDetailViewController * cmwDVC = [[HJCMWDetailViewController alloc]init];
    cmwDVC.title = @"公益";
    [[self getCurrentViewController].navigationController pushViewController:cmwDVC animated:YES];
    
}


@end

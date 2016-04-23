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
#define TEAM_URL @"vtlist"

@interface HJCMWTeamViewController ()<UITableViewDelegate,UITableViewDataSource>
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 是否正在刷新*/
@property(nonatomic, assign) Boolean isRefreshing;
/** 是否正在加载*/
@property(nonatomic, assign) Boolean isLoading;
@end

@implementation HJCMWTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}
- (void)createValue{
    _dataSource = [NSMutableArray array];
//    for (int i = 0; i < 3; i ++) {
//        HJTeamModel * model = [[HJTeamModel alloc]init];
//        model.teamIcon = [NSString stringWithFormat:@"team_img%02d",i+1];
//        [_dataSource addObject:model];
//    }
    [self loadData];
}
- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rect ;
    if (self.userid.length) {
        rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        
    }else{
        rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    }
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 90;
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

    [self.view addSubview:self.tableV];
}
- (void)loadData{
    
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,TEAM_URL];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    if (self.userid && _isAll)
        [dic setObject:self.userid forKey:@"userid"];
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        [_dataSource removeAllObjects];
//        HJLog(@"%@",responseObject);
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * dataArr = jsonData[@"pd"];
        for (NSDictionary * dic in dataArr) {
            HJTeamModel * model = [HJTeamModel mj_objectWithKeyValues:dic];
            [_dataSource addObject:model];
        }
        [self.tableV reloadData];
        
    } fail:^(NSError *error) {
        
    }];
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
    }
    cell.indexPath = indexPath;
    
    if (_dataSource[indexPath.row])
    cell.model = _dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HJTeamCenterViewController * teamCenterVC = [[HJTeamCenterViewController alloc]init];
    teamCenterVC.model = _dataSource[indexPath.row];
    [self.navigationController pushViewController:teamCenterVC animated:YES];
}

@end

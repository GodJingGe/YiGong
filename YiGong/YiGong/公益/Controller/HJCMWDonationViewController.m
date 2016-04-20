//
//  HJCMWDonationViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJCMWDonationViewController.h"
#import "HJDonationTableViewCell.h"
#import "HJDonationModel.h"
#import "HJDonationDetailViewController.h"
#define DONATION_URL @"vdlist"
@interface HJCMWDonationViewController ()<UITableViewDelegate,UITableViewDataSource>
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 是否正在刷新*/
@property(nonatomic, assign) Boolean isRefreshing;
/** 是否正在加载*/
@property(nonatomic, assign) Boolean isLoading;

@end

@implementation HJCMWDonationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}
- (void)createValue{
    _dataSource = [NSMutableArray array];
//    for (int i = 0; i < 3; i ++) {
//        HJDonationModel * model = [[HJDonationModel alloc]init];
//        [_dataSource addObject:model];
//    }
    [self loadData];
    
}
- (void)loadData{
    
    
    HJRequestTool * request = [[HJRequestTool alloc]init];
    NSString * url= [NSString stringWithFormat:COMMON_URL,DONATION_URL];
    NSDictionary * dic = [NSDictionary dictionary];
    [request postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        [_dataSource removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr = dic[@"pd"];
        for (NSDictionary * dict in arr) {
            HJDonationModel *model = [HJDonationModel mj_objectWithKeyValues:dict];
            [_dataSource addObject:model];

        }
        [_tableV reloadData];
    } fail:^(NSError *error) {
        
    }];
}

- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
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



#pragma mark --------------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJPartakeTableViewCell";
    HJDonationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJDonationTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        cell.indexPath = indexPath;
        cell.isAvatar = NO;
        cell.model = _dataSource[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HJDonationDetailViewController * donationDetailVC = [[HJDonationDetailViewController alloc]init];
    donationDetailVC.title = @"捐赠物品";
    if (_dataSource[indexPath.row]) {
        donationDetailVC.model = _dataSource[indexPath.row];
    }
    [self.navigationController pushViewController:donationDetailVC animated:YES];
}

@end

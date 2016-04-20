//
//  HJGCMServiceViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJGCMServiceViewController.h"
#import "HJGCMServiceTableViewCell.h"
#import "HJGcmModel.h"
#import "HJServiceDetailViewController.h"
#define GCM_URL @"gmlist"

@interface HJGCMServiceViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 是否正在刷新*/
@property(nonatomic, assign) Boolean isRefreshing;
/** 是否正在加载*/
@property(nonatomic, assign) Boolean isLoading;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 模型*/
@property(nonatomic, strong) HJGcmModel *model;
/** UITableViewCell*/
@property(nonatomic, strong) HJGCMServiceTableViewCell *cell;
@end

@implementation HJGCMServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}
- (void)createValue{
    _dataSource = [NSMutableArray array];
    [self loadData];
}
- (void)createUI{
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
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
    [self.view addSubview:self.tableV];
    
}
- (void)loadData{
    [_dataSource removeAllObjects];
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSString * url = [NSString stringWithFormat:COMMON_URL,GCM_URL];
    [tool postJSONWithUrl:url parameters:nil success:^(id responseObject) {
        
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * arr = jsonData[@"pd"];
        for (NSDictionary * dic in arr) {
            HJGcmModel * model = [HJGcmModel mj_objectWithKeyValues:dic];
            [_dataSource addObject:model];
        }
        [_tableV reloadData];
    } fail:^(NSError *error) {
        
    }];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJGCMServiceTableViewCell";
    _cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!_cell) {
        _cell = [[HJGCMServiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        if (_dataSource[indexPath.section]) {
            _cell.model = _dataSource[indexPath.section];
            [_cell setCallToGcmBlock:^(NSString *number) {
//                number = @"15168412087";
                NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
            
            }];
        }
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
    HJServiceDetailViewController * serviceDetailVC = [[HJServiceDetailViewController alloc]init];
    HJGcmModel * model = _dataSource[indexPath.row];
    serviceDetailVC.title = model.gcmName;
    serviceDetailVC.model = _dataSource[indexPath.section];
    [self.navigationController pushViewController:serviceDetailVC animated:YES];
    
}
@end

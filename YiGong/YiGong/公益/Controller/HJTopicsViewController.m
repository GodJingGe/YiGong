//
//  HJTopicsViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTopicsViewController.h"
#import "HJTopicsTableViewCell.h"
#import "HJTopicModel.h"
#import "HJPublishViewController.h"
#import "HJTopicDetailViewController.h"
#define TOPIC_URL @"vttlist"

@interface HJTopicsViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 标签栏*/
@property(nonatomic, strong) UITabBar *tabbar;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HJTopicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}
- (void)createValue{
    _dataSource = [NSMutableArray array];
//    for (int i = 0; i < 3; i ++) {
//        HJTopicModel * model = [[HJTopicModel alloc]init];
//        [_dataSource addObject:model];
//    }
    [self loadData];
}

- (void)loadData{
    HJRequestTool * tool = [[HJRequestTool alloc]init];
    NSDictionary * dic = [NSDictionary dictionaryWithObject:self.teamId forKey:@"vtid"];
    NSString * url = [NSString stringWithFormat:COMMON_URL,TOPIC_URL];
    
    [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
        NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * dataArr = jsonData[@"pd"];
        for (NSDictionary * dic in dataArr) {
            HJTopicModel * model = [HJTopicModel mj_objectWithKeyValues:dic];
            [_dataSource addObject:model];
        }
        [self.tableV reloadData];
    } fail:^(NSError *error) {
        
    }];
}

- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.rowHeight = 75;
    [self.view addSubview:self.tableV];
    
    _tabbar = [[UITabBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-49, SCREEN_WIDTH, 49)];
    [_tabbar setShadowImage:[UIImage new]];
    [self.view addSubview:_tabbar];
    
    UIButton * publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    publishBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);
    [publishBtn setBackgroundColor:HJRGBA(248, 97, 111, 1.0)];
    [publishBtn setTitle:@"发布话题" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishTopic:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabbar addSubview:publishBtn];
}

#pragma mark --------------ClickAction
- (void)publishTopic:(UIButton *)button{
    HJPublishViewController * publishVC = [[HJPublishViewController alloc]init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJTopicsTableViewCell";
    HJTopicsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJTopicsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        cell.indexPath = indexPath;
        cell.model = _dataSource[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HJTopicDetailViewController * topicDetailVC = [[HJTopicDetailViewController alloc]init];
    topicDetailVC.title = self.teamName;
    topicDetailVC.topicModel = _dataSource[indexPath.row];
    [self.navigationController pushViewController:topicDetailVC animated:YES];
}


@end

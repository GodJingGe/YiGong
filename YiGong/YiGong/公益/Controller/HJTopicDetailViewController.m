//
//  HJTopicDetailViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTopicDetailViewController.h"
#import "HJTopicDetailTableViewCell.h"
#import "HJDetailHeaderView.h"
@interface HJTopicDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 标签栏*/
@property(nonatomic, strong) UITabBar *tabbar;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HJTopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}
- (void)createValue{
    _dataSource = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        HJTopicModel * model = [[HJTopicModel alloc]init];
        [_dataSource addObject:model];
    }
}
- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
    _tabbar = [[UITabBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-49, SCREEN_WIDTH, 49)];
    [_tabbar setShadowImage:[UIImage new]];
    [self.view addSubview:_tabbar];
    
    UIButton * replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    replyBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);
    [replyBtn setBackgroundColor:HJRGBA(248, 97, 111, 1.0)];
    [replyBtn setTitle:@"回复他" forState:UIControlStateNormal];
    [replyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [replyBtn addTarget:self action:@selector(replyTopic:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabbar addSubview:replyBtn];
}

#pragma mark --------------ClickAction
- (void)replyTopic:(UIButton *)button{
    HJLog(@"回复他");
}

#pragma mark --------------UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section) return _dataSource.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * detailCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return detailCell.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJTopicDetailTableViewCell";
    HJTopicDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJTopicDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        cell.indexPath = indexPath;
        if (indexPath.section) {
            cell.model = _dataSource[indexPath.row];
        }else{
            cell.model = self.topicModel;
        }
    }
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HJDetailHeaderView * header = [[HJDetailHeaderView alloc]init];
    header.titleLabel.text = @"精彩评论";
    if (section) return header;
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!section) return 0.0001f;
    return 50;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

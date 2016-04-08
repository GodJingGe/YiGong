//
//  HJTakePartInViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTakePartInViewController.h"
#import "HJTakePartInTableViewCell.h"
#import "HJTakePartInModel.h"
@interface HJTakePartInViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HJTakePartInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self viewConfig];
}
- (void)createValue{
    _dataSource = [NSMutableArray array];
    NSArray * titles = @[@"昵称",@"真实姓名",@"出生年月",@"性别",@"手机号码",@"验证码"];
    NSArray * detail = @[@"沐沐沐雅",@"张沐雅",@"1992-02-14",@"女",@"186 6634 3752",@"352671"];
    for (int i = 0; i < titles.count; i ++) {
        HJTakePartInModel * model = [[HJTakePartInModel alloc]init];
        model.title = titles[i];
        model.detail = detail[i];
        [_dataSource addObject:model];
    }
}
- (void)viewConfig{
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJPartakeTableViewCell";
    HJTakePartInTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJTakePartInTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        cell.indexPath = indexPath;
        cell.model = _dataSource[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --------------UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}

@end

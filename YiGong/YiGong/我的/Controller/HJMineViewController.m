//
//  HJMineViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJMineViewController.h"
#import "HJPersonalCenterView.h"
#import "HJMineTableViewCell.h"

@interface HJMineViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 图片*/
@property(nonatomic, strong) HJPersonalCenterView *centerView;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HJMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self createUI];
}
- (void)createUI{
    
    CGRect rect = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableV = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    
    [self.view addSubview:self.tableV];
    
    _centerView = [[HJPersonalCenterView alloc]init];
    [self.tableV addSubview:_centerView];
    self.tableV.contentInset=UIEdgeInsetsMake(_centerView.frame.size.height,0,0,0);
    
}
- (void)loadData{
    _dataSource = [NSMutableArray array];
    NSArray * titles = @[@"认证公益团队",@"意见反馈",@"清除缓存"];
    [_dataSource addObjectsFromArray:titles];
}

#pragma mark --------------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseID = @"HJMainTableViewCell";
    HJMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[HJMineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.titleLabel.text = _dataSource[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0)  return 0.0001f;
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) return 304;
    UITableViewCell * detailCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return detailCell.frame.size.height;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark --------------UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    /**
     *  关键处理：通过滚动视图获取到滚动偏移量从而去改变图片的变化
     */
    //获取滚动视图y值的偏移量
    CGFloat yOffset  = scrollView.contentOffset.y;
    HJLog(@"yOffset===%f",yOffset);
    
    if(yOffset < -226) {
        
        CGRect f =self.centerView.frame;
        f.origin.y= yOffset ;
        f.size.height=  -yOffset;
        self.centerView.frame= f;
        
    }
    
    if (yOffset >= -64) {
        [self setNavigationBarStyleNormal];
        
    }else{
        [self setNavigationBarStyleClear];
    }
    
}

// 设置导航栏透明
- (void)setNavigationBarStyleClear{
    
    UIColor * color = [UIColor clearColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    self.navigationController.navigationBar.translucent = YES;
    
}

// 设置导航栏正常
- (void)setNavigationBarStyleNormal{
    
    UIColor * color = HJRGBA(248, 97, 111, 1.0);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarStyleClear];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setNavigationBarStyleNormal];
}
@end

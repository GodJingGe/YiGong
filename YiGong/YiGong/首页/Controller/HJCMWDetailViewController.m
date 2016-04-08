//
//  HJCMWDetailViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/3/31.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJCMWDetailViewController.h"
#import "HJDetailSuperTableView.h"
#import "HJTakePartInViewController.h"

@interface HJCMWDetailViewController ()
/** tableView*/
@property(nonatomic, strong)  HJDetailSuperTableView *superTableV;
/** 标签栏*/
@property(nonatomic, strong) UITabBar *tabbar;
/** 评论 */
@property(nonatomic, strong) UIButton *commentBtn;
/** 报名*/
@property(nonatomic, strong) UIButton *partakeBtn;

@end

@implementation HJCMWDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    _superTableV = [[HJDetailSuperTableView alloc]init];
    [self.view addSubview:_superTableV];
    
    [self createTabbar];
}
- (void)createTabbar{
    _tabbar = [[UITabBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-49, SCREEN_WIDTH, 49)];
    [_tabbar setShadowImage:[UIImage new]];
    [self.view addSubview:_tabbar];
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _commentBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 49);
    _commentBtn.backgroundColor = HJRGBA(248, 97, 111, 1.0);
    [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_tabbar addSubview:_commentBtn];
    
    _partakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _partakeBtn.frame = CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 49);
    _partakeBtn.backgroundColor = HJRGBA(234, 83, 97, 1.0);
    [_partakeBtn setTitle:@"立刻报名" forState:UIControlStateNormal];
    [_partakeBtn addTarget:self action:@selector(partakeActivityAction:) forControlEvents:UIControlEventTouchUpInside];
    _partakeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_partakeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_tabbar addSubview:_partakeBtn];
}
// 设置导航栏透明
- (void)setNavigationBarStyleClear{
    
    UIColor * color = [UIColor clearColor];
    UIButton * praise = [UIButton buttonWithType:UIButtonTypeCustom];
    praise.frame = CGRectMake(15, SCREEN_HEIGHT - 184, 50, 50);
    [praise setBackgroundImage:[UIImage imageNamed:@"laud01"] forState:UIControlStateNormal];
    [praise setBackgroundImage:[UIImage imageNamed:@"laud02"] forState:UIControlStateSelected];
    [praise addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:praise];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:praise];
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

#pragma mark --------------ClickAction
- (void)praiseAction:(UIButton *)button{
    HJLog(@"点赞");
    if (button.selected) return;
    button.selected = YES;
    
}

- (void)partakeActivityAction:(UIButton *)button{
    HJTakePartInViewController * takePartInVC = [[HJTakePartInViewController alloc]init];
    [self.navigationController pushViewController:takePartInVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarStyleClear];
    [self.superTableV scrollViewDidScroll:self.superTableV.tableV];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setNavigationBarStyleNormal];
}
@end

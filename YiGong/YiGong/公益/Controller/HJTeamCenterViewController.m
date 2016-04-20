//
//  HJTeamCenterViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTeamCenterViewController.h"
#import "HJTeamCenterView.h"
#import "HJTeamModel.h"
#import "HJTopicsViewController.h"
@interface HJTeamCenterViewController ()
/** 详情视图*/
@property(nonatomic, strong) HJTeamCenterView *teamCenterView;
/** tabbar*/
@property(nonatomic, strong) UITabBar *tabbar;
/** topicsBtn*/
@property(nonatomic, strong) UIButton *topicsBtn;
@end

@implementation HJTeamCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
}
- (void)createValue{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _teamCenterView = [[HJTeamCenterView alloc]init];
    _teamCenterView.model = self.model;
    
    _tabbar = [[UITabBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-49, SCREEN_WIDTH, 49)];
    [_tabbar setShadowImage:[UIImage new]];
    [_tabbar setBackgroundColor:THEME_COLOR];
    [self.view addSubview:_tabbar];
    
    _topicsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _topicsBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);
    [_topicsBtn setBackgroundImage:[UIImage imageWithColor:THEME_COLOR] forState:UIControlStateNormal];
    [_topicsBtn setTitle:@"进入话题" forState:UIControlStateNormal];
    [_topicsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_topicsBtn addTarget:self action:@selector(pushToTopicsVC:) forControlEvents:UIControlEventTouchUpInside];
    [_tabbar addSubview:_topicsBtn];
    
    _teamCenterView.frame = CGRectMake(0, -64, SCREEN_WIDTH, 270);
    _teamCenterView.model = _model;
    [self.view addSubview:_teamCenterView];
}


#pragma mark --------------ClickAction
- (void)pushToTopicsVC:(UIButton *)button{
    HJTopicsViewController * topicsVC = [[HJTopicsViewController alloc]init];
    topicsVC.title = _model.teamName;
    topicsVC.teamName = _model.teamName;
    topicsVC.teamId = _model.teamId;
    [self.navigationController pushViewController:topicsVC animated:YES];
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

- (void)viewWillAppear:(BOOL)animated
{
    [self setNavigationBarStyleClear];
}
- (void)viewDidAppear:(BOOL)animated{
    
}
@end

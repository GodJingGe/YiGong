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
@end

@implementation HJTeamCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
}
- (void)createValue{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    HJTeamModel * model = [[HJTeamModel alloc]init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _teamCenterView = [[HJTeamCenterView alloc]init];
    
    __weak typeof(self) weakSelf = self;
   
    [_teamCenterView setPushToTopicsVCBlock:^{
        HJTopicsViewController * topicsVC = [[HJTopicsViewController alloc]init];
        topicsVC.title = model.teamName;
        topicsVC.teamName = model.teamName;
        [weakSelf.navigationController pushViewController:topicsVC animated:YES];
    }];
    _teamCenterView.frame = CGRectMake(0, -64, SCREEN_WIDTH, 270);
    _teamCenterView.model = model;
    [self.view addSubview:_teamCenterView];
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

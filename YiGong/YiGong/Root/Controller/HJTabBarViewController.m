//
//  HJTabBarViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTabBarViewController.h"
#import "HJMainViewController.h"
#import "HJCMWViewController.h"
#import "HJGCMViewController.h"
#import "HJMineViewController.h"
#import "HJNavigationViewController.h"
#import "JPUSHService.h"
@interface HJTabBarViewController ()

@end

@implementation HJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)createUI{
    
    HJMainViewController * mainVC = [[HJMainViewController alloc]init];
    HJCMWViewController * cmwVC = [[HJCMWViewController alloc]init];
    HJGCMViewController * gcmVC = [[HJGCMViewController alloc]init];
    HJMineViewController * mineVC = [[HJMineViewController alloc]init];
    
    [self addOneChildViewController:mainVC WithTitle:@"首页" normalImageName:@"home" selectedImageName:@"home_act"];
    [self addOneChildViewController:cmwVC WithTitle:@"公益" normalImageName:@"PW" selectedImageName:@"pw_act"];
    [self addOneChildViewController:gcmVC WithTitle:@"健康" normalImageName:@"health" selectedImageName:@"health_act"];
    [self addOneChildViewController:mineVC WithTitle:@"我的" normalImageName:@"ME" selectedImageName:@"me_act"];
    
}

- (void)addOneChildViewController:(UIViewController *)viewController WithTitle:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName {
    
    self.tabBar.backgroundColor = HJRGBA(248, 248, 248, 1.0);
    [[UITabBarItem appearance] setTitleTextAttributes:                                                         [NSDictionary dictionaryWithObjectsAndKeys:HJRGBA(248, 97, 111, 1.0),NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    viewController.title = title;
    
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = normalImage;
    
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    viewController.tabBarItem.selectedImage = selectedImage;
    
    HJNavigationViewController *baseNav = [[HJNavigationViewController alloc] initWithRootViewController:viewController];
    
    baseNav.navigationBar.translucent = NO;
    
    [self addChildViewController:baseNav];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

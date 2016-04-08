//
//  HJRootViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRootViewController.h"

@interface HJRootViewController ()

@end

@implementation HJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConfig];
    [self createNavigationAbount];
}

- (void)viewConfig{
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置状态栏颜色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)createNavigationAbount{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    self.navigationController.navigationBar.barTintColor = HJRGBA(248,97,111,1.0);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:HJRGBA(248,97,111,1.0)] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName,nil]];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title =@"";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  HJSearchViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJSearchViewController.h"

@interface HJSearchViewController ()<UISearchBarDelegate>
/** searchBar*/
@property(nonatomic, strong) UISearchBar *searchBar;
@end

@implementation HJSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入团队名称";
    self.searchBar.backgroundImage = [UIImage imageWithColor:[UIColor clearColor]];
    self.searchBar.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    [self.navigationController.view addSubview:self.searchBar];
}

#pragma mark --------------UITouch

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar resignFirstResponder];
}

#pragma mark --------------UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:YES];
    for(id cc in [searchBar.subviews[0] subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            
            [btn setTitleColor:HJRGBA(28, 174, 189, 1.0) forState:UIControlStateNormal];
        }
    }
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self.searchBar setShowsCancelButton:NO];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}
#pragma mark --------------SystemDelegate
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:HJRGBA(240, 239, 245, 1.0)] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController.view addSubview:self.searchBar];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:HJRGBA(248, 97, 111, 1.0)] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.searchBar removeFromSuperview];
    
}
@end

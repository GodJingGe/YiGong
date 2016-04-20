//
//  HJGCMViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJGCMViewController.h"
#import "HJGCMServiceViewController.h"
#import "HJHealthManagerViewController.h"
#import "HJGCMAssessViewController.h"
#import "HJLocationLabel.h"
#import "HJAreaPickerView.h"
@interface HJGCMViewController ()
/** 当前位置*/
@property(nonatomic, strong) HJLocationLabel *locationLabel;
/** 选择当前位置*/
@property(nonatomic, strong) HJAreaPickerView *areaPicker;
/** 当前窗口*/
@property(nonatomic, strong) UIWindow *window;
/** 养老服务*/
@property(nonatomic, strong) HJGCMServiceViewController *serviceVC;
/** 健康管家*/
@property(nonatomic, strong) HJHealthManagerViewController *healthVC;
/** 养老评估*/
@property(nonatomic, strong) HJGCMAssessViewController *assessVC;
@end

@implementation HJGCMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}
- (void)createValue{
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.view.backgroundColor = [UIColor whiteColor];

    _window = [UIApplication sharedApplication].keyWindow;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"location"] style:UIBarButtonItemStyleDone target:self action:@selector(changeSite)];
    
    _serviceVC = [[HJGCMServiceViewController alloc]init];
    _serviceVC.title = @"养老服务";
    
    
    _healthVC = [[HJHealthManagerViewController alloc]init];
    _healthVC.title = @"健康管家";
    
    
    _assessVC = [[HJGCMAssessViewController alloc]init];
    _assessVC.title = @"养老评估";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[_serviceVC, _healthVC, _assessVC];
    navTabBarController.showArrowButton = NO;
    navTabBarController.navTabBarColor = [UIColor whiteColor];
    
    [navTabBarController addParentController:self];
}
- (void)createUI{
    
    _locationLabel = [[HJLocationLabel alloc]init];
    [self.navigationController.navigationBar addSubview:_locationLabel];
}

#pragma mark --------------ClickAction
- (void)changeSite{
    __weak typeof(self) weakSelf = self;
    _areaPicker = [[HJAreaPickerView alloc]initWithArea:^(NSString *province, NSString *city) {
        weakSelf.locationLabel.text = city;
    }];
    
}

#pragma mark --------------systemDelegate
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar addSubview:self.locationLabel];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.locationLabel removeFromSuperview];
}
@end

//
//  HJCMWViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJCMWViewController.h"
#import "HJCMWTeamViewController.h"
#import "HJCMWActivityViewController.h"
#import "HJCMWDonationViewController.h"
#import "HJLocationLabel.h"
#import "HJAreaPickerView.h"
#import "HJSearchViewController.h"
#import "HJReleaseDonationViewController.h"
@interface HJCMWViewController ()
/** 当前位置*/
@property(nonatomic, strong) HJLocationLabel *locationLabel;
/** 选择当前位置*/
@property(nonatomic, strong) HJAreaPickerView *areaPicker;
/** 当前窗口*/
@property(nonatomic, strong) UIWindow *window;
/** 公益团队*/
@property(nonatomic, strong) HJCMWTeamViewController *teamVC;
/** 公益活动*/
@property(nonatomic, strong) HJCMWActivityViewController *activityVC;
/** 公益捐赠*/
@property(nonatomic, strong) HJCMWDonationViewController *donationVC;
@end

@implementation HJCMWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self viewConfig];
    [self createUI];
}
- (void)viewConfig{
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"公益";
    _window = [UIApplication sharedApplication].keyWindow;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"location"] style:UIBarButtonItemStyleDone target:self action:@selector(changeSite)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
    
    _teamVC = [[HJCMWTeamViewController alloc]init];
    _teamVC.title = @"公益团队";
    
    
    _activityVC = [[HJCMWActivityViewController alloc]init];
    _activityVC.title = @"公益活动";
    
    
    _donationVC = [[HJCMWDonationViewController alloc]init];
    _donationVC.title = @"公益捐赠";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[_teamVC, _activityVC, _donationVC];
    navTabBarController.showArrowButton = NO;
    navTabBarController.navTabBarColor = [UIColor whiteColor];
    [navTabBarController setChangeRightItem:^(NSInteger item) {
        if (item == 0) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
        }else if(item == 2){
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStyleDone target:self action:@selector(addDonationAction)];
        }else{
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]init];
        }
    }];

    [navTabBarController addParentController:self];
}
- (void)createUI{
    __weak typeof(self) weakSelf = self;
    _areaPicker = [[HJAreaPickerView alloc]init];
    
    [self.areaPicker setChangeAreaBlock:^(NSString *area) {
        weakSelf.locationLabel.text = area;
    }];
    _locationLabel = [[HJLocationLabel alloc]init];
    [self.navigationController.navigationBar addSubview:_locationLabel];
}

#pragma mark --------------ClickAction
- (void)changeSite{
    
    [_window addSubview:_areaPicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDidStopSelector:@selector(changeAreaViewState)];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:0];
    _areaPicker.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
}

- (void)searchAction{
    HJLog(@"search");
    HJSearchViewController * searchVC = [[HJSearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)addDonationAction{
    HJLog(@"add");
    HJRleaseDonationViewController * releaseVC = [[HJRleaseDonationViewController alloc]init];
    releaseVC.title = @"发布捐赠";
    releaseVC.placeholder = @"请在此输入信息";
    [self.navigationController pushViewController:releaseVC animated:YES];
}
// 动画结束调用
- (void)changeAreaViewState{
    _areaPicker.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.1 brightness:0.1 alpha:0.5];
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

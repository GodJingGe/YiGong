//
//  HJMainViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJMainViewController.h"
#import "HJLocationLabel.h"
#import "HJAreaPickerView.h"
#import "HJTableSuperView.h"
@interface HJMainViewController ()
/** 当前位置*/
@property(nonatomic, strong) HJLocationLabel *locationLabel;
/** 选择当前位置*/
@property(nonatomic, strong) HJAreaPickerView *areaPicker;
/** 当前窗口*/
@property(nonatomic, strong) UIWindow *window;
/** HJTableSuperView*/
@property(nonatomic, strong) HJTableSuperView *superTableView;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
    [self createUI];
}

#pragma mark --------------CreateByMyself
- (void)createUI{
    __weak typeof(self) weakSelf = self;
    _areaPicker = [[HJAreaPickerView alloc]init];
    
    [self.areaPicker setChangeAreaBlock:^(NSString *area) {
        weakSelf.locationLabel.text = area;
    }];
    _locationLabel = [[HJLocationLabel alloc]init];
    [self.navigationController.navigationBar addSubview:_locationLabel];
    
}

- (void)createValue{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _superTableView = [[HJTableSuperView alloc]init];
    
    [self.view addSubview:_superTableView];
    _window = [UIApplication sharedApplication].keyWindow;
    
    self.view.backgroundColor = [UIColor greenColor];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"location"] style:UIBarButtonItemStyleDone target:self action:@selector(changeSite)];
    
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
// 动画结束调用
- (void)changeAreaViewState{
    _areaPicker.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.1 brightness:0.1 alpha:0.5];
}

#pragma mark --------------SystemDelegate
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar addSubview:self.locationLabel];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.locationLabel removeFromSuperview];
}
@end

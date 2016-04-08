//
//  HJCMWActivityViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJCMWActivityViewController.h"
#import "HJAreaPickerView.h"
#import "HJTableSuperView.h"

@interface HJCMWActivityViewController ()
/** HJTableSuperView*/
@property(nonatomic, strong) HJTableSuperView *superTableView;
@end

@implementation HJCMWActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
}

#pragma mark --------------CreateByMyself
- (void)createValue{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _superTableView = [[HJTableSuperView alloc]init];
    _superTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44 - 49);
    _superTableView.tableV.frame = _superTableView.bounds;
    [self.view addSubview:_superTableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

@end

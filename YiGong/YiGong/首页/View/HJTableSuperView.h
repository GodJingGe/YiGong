//
//  HJTableSuperView.h
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJMainModel.h"
#import "HJMainTableViewCell.h"
#import "HJCMWDetailViewController.h"
#import "HJRootTableSuperView.h"
@interface HJTableSuperView :HJRootTableSuperView <UITableViewDataSource,UITableViewDelegate>
/** 是否正在刷新*/
@property(nonatomic, assign) Boolean isRefreshing;
/** 是否正在加载*/
@property(nonatomic, assign) Boolean isLoading;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 模型*/
@property(nonatomic, strong) HJMainModel *model;
/** UITableViewCell*/
@property(nonatomic, strong) HJMainTableViewCell *cell;
@end

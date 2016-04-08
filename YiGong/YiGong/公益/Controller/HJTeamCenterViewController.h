//
//  HJTeamCenterViewController.h
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRootViewController.h"
#import "HJTeamModel.h"

@interface HJTeamCenterViewController : HJRootViewController

/** 图片*/
@property(nonatomic, strong) UIImageView *topicImageView;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 模型*/
@property(nonatomic, strong) HJTeamModel *model;

@end

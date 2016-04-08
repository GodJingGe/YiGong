//
//  HJDetailSuperTableView.h
//  YiGong
//
//  Created by 黄靖 on 16/3/31.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJRootTableSuperView.h"
#import "HJDetailTableViewCell.h"
#import "HJMainModel.h"
@interface HJDetailSuperTableView : HJRootTableSuperView<UITableViewDataSource,UITableViewDelegate>

/** 图片*/
@property(nonatomic, strong) UIImageView *topicImageView;
/** UITableView*/
@property(nonatomic, strong) UITableView *tableV;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 模型*/
@property(nonatomic, strong) HJMainModel *model;
/** UITableViewCell*/
@property(nonatomic, strong) HJDetailTableViewCell *cell;

- (void)scrollViewDidScroll:(UIScrollView*)scrollView;
@end

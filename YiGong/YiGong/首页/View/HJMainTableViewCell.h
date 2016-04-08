//
//  HJMainTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJMainModel.h"
#import "HJMainSummaryView.h"
@interface HJMainTableViewCell : UITableViewCell
/** 图片*/
@property(nonatomic, strong) UIImageView *topicImageView;
/** 活动摘要*/
@property(nonatomic, strong) HJMainSummaryView *summaryView;
/** 模型*/
@property(nonatomic, strong)  HJMainModel *model;
@end

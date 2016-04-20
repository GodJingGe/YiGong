//
//  HJGCMServiceTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGcmModel.h"
#import "HJServiceSummary.h"
@interface HJGCMServiceTableViewCell : UITableViewCell
/** 模型*/
@property(nonatomic, strong) HJGcmModel *model;
/** 图片*/
@property(nonatomic, strong) UIImageView *topicImageView;
/** 摘要*/
@property(nonatomic, strong) HJServiceSummary *summaryView;

/** 拨打电话*/
@property (nonatomic, copy) void (^callToGcmBlock)(NSString *);
@end

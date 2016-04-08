//
//  HJMainSummaryView.h
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJMainModel.h"
@interface HJMainSummaryView : UIView
/** 模型*/
@property(nonatomic, strong) HJMainModel *model;
/** 标题图标*/
@property(nonatomic, strong) UIImageView *titleImageV;
/** 位置图标*/
@property(nonatomic, strong) UIImageView *locationImageV;
/** 标题*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 位置*/
@property(nonatomic, strong) UILabel *locationLabel;
/** 活动时间*/
@property(nonatomic, strong) UILabel *dateTimeLabel;
/** 活动状态*/
@property(nonatomic, strong) UILabel *stateLabel;
/** 活动人数*/
@property(nonatomic, strong) UILabel *personsLabel;
@end

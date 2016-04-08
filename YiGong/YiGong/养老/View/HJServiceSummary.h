//
//  HJServiceSummary.h
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGcmModel.h"
@interface HJServiceSummary : UIView
/** 模型*/
@property(nonatomic, strong) HJGcmModel *model;
/** 标题图标*/
@property(nonatomic, strong) UIImageView *titleImageV;
/** 位置图标*/
@property(nonatomic, strong) UIImageView *locationImageV;
/** 标题*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 位置*/
@property(nonatomic, strong) UILabel *locationLabel;
/** 拨打电话*/
@property (nonatomic, copy) UIButton *callBtn;
@end

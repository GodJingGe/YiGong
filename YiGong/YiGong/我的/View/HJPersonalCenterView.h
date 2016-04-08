//
//  HJPersonalCenterView.h
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJLogoView.h"
#import "HJTeamItemView.h"
#import "HJTeamModel.h"

@interface HJPersonalCenterView : UIView
/** 模型*/
@property(nonatomic, strong) HJTeamModel *model;
/** 背景视图*/
@property(nonatomic, strong) UIImageView *backgroundView;
/** Logo*/
@property(nonatomic, strong) HJLogoView *logoView;
/** 团队名称*/
@property(nonatomic, strong) UILabel *teamNameLabel;
/** 关注人数*/
@property(nonatomic, strong) HJTeamItemView *followView;
/** 参与话题*/
@property(nonatomic, strong) HJTeamItemView *releatedTopicView;
/** 注册时间*/
@property(nonatomic, strong) HJTeamItemView *registerView;
/** 详情*/
@property(nonatomic, strong) UITextView *detailTextV;

@end

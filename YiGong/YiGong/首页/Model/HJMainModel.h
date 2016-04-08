//
//  HJMainModel.h
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJMainModel : NSObject
/** topicImage*/
@property(nonatomic, strong) UIImage *topicImage;
/** 活动主题*/
@property(nonatomic,copy)NSString *activityTitle;
/** 活动地点*/
@property(nonatomic,copy)NSString *activityAddress;
/** 活动时间*/
@property(nonatomic,copy)NSString *activityTime;
/** 活动人数*/
@property(nonatomic,copy)NSString *activityPersons;
/** 活动总人数*/
@property(nonatomic,copy)NSString *totalPersons;
/** 活动状态*/
@property(nonatomic,copy)NSString *activityState;
@end

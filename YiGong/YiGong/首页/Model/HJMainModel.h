//
//  HJMainModel.h
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJMainImageModel.h"

@interface HJMainModel : NSObject
/** 活动编号*/
@property (nonatomic, copy) NSString *activityId;
/** topicImage*/
@property (nonatomic, strong) NSMutableArray *images;
/** 活动主题*/
@property (nonatomic, copy) NSString *activityTitle;
/** 活动介绍*/
@property (nonatomic, copy) NSString *activityContent;
/** 活动行程*/
@property (nonatomic, copy) NSString *activitySchedule;
/** 主办方*/
@property (nonatomic, copy) NSString *teamName;
/** 活动地点*/
@property (nonatomic, copy) NSString *activityAddress;
/** 活动时间*/
@property (nonatomic, copy) NSString *activityTime;
/** 活动人数*/
@property (nonatomic, copy) NSString *activityPersons;
/** 活动总人数*/
@property (nonatomic, copy) NSString *totalPersons;
/** 活动状态*/
@property (nonatomic, copy) NSString *activityState;
@end

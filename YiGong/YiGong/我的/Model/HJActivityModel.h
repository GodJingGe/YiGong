//
//  HJActivityModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJActivityModel : NSObject
/** 主题图片*/
@property(nonatomic, strong) UIImage *themeImage;
/** 活动主题*/
@property (nonatomic, copy) NSString *title;
/** 活动城市*/
@property (nonatomic, copy) NSString *city;
/** 活动地址*/
@property (nonatomic, copy) NSString *address;
/** 活动时间*/
@property (nonatomic, copy) NSString *startTime;
/** 结束时间*/
@property (nonatomic, copy) NSString *endTime;
/** 活动人数*/
@property (nonatomic, copy) NSString *personNum;
/** 主办方*/
@property (nonatomic, copy) NSString *sponsor;
/** 活动介绍*/
@property (nonatomic, copy) NSString *desc;
/** 日程安排*/
@property (nonatomic, copy) NSString *agenda;
@end

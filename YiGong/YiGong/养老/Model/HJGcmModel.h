//
//  HJGcmModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJGcmModel : NSObject
/** 养老院Id*/
@property (nonatomic, copy) NSString *gcmId;
/** 养老院图片*/
@property (nonatomic, copy) NSString *gcmAvatar;
/** 养老院名称*/
@property (nonatomic, copy) NSString *gcmName;
/** 养老院联系方式*/
@property (nonatomic, copy) NSString *phoneNum;
/** 养老院地址*/
@property (nonatomic, copy) NSString *gcmAddress;
/** 养老院简介*/
@property (nonatomic, copy) NSString *gcmSummary;
/** 养老院服务*/
@property (nonatomic, copy) NSString *gcmService;
/** 医疗服务*/
@property (nonatomic, copy) NSString *healthCare;
/** 康娱设施*/
@property (nonatomic, copy) NSString *rctEquipment;
@end

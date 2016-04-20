//
//  HJDonationModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJDonationImageModel.h"

@interface HJDonationModel : NSObject
/** 捐赠图片*/
@property (nonatomic, copy) NSMutableArray <HJDonationImageModel *>*images;
/** title*/
@property (nonatomic, copy) NSString *title;
/** 用户id*/
@property (nonatomic, copy) NSString *donorId;
/** 用户头像*/
@property (nonatomic, copy) NSString *avatar;
/** 捐赠id*/
@property (nonatomic, copy) NSString *donattionId;
/** 详细内容*/
@property (nonatomic, copy) NSString *content;
/** 捐赠对象*/
@property (nonatomic, copy) NSString *donee;
/** 捐赠者*/
@property (nonatomic, copy) NSString *donor;
/** 发布时间*/
@property (nonatomic, copy) NSString *timeDate;

@end

//
//  HJDonationModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJDonationModel : NSObject
/** 头像*/
@property (nonatomic, copy) NSString *goodsIcon;
/** title*/
@property (nonatomic, copy) NSString *title;
/** 详细内容*/
@property (nonatomic, copy) NSString *content;
/** 捐赠对象*/
@property (nonatomic, copy) NSString *donee;
/** 捐赠者*/
@property (nonatomic, copy) NSString *donor;
/** 发布时间*/
@property (nonatomic, copy) NSString *timeDate;

@end

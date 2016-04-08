//
//  HJTopicModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJTopicModel : NSObject
/** 头像*/
@property (nonatomic, copy) NSString *avatar;
/** title*/
@property (nonatomic, copy) NSString *title;
/** 内容*/
@property (nonatomic, copy) NSString *content;
/** 发布人*/
@property (nonatomic, copy) NSString *author;
/** 发布时间*/
@property (nonatomic, copy) NSString *timeDate;
@end

//
//  HJTeamModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJTeamModel : NSObject
/** 团队名*/
@property (nonatomic, copy) NSString *teamName;
/** 头像*/
@property (nonatomic, copy) NSString *teamIcon;
/** 标题*/
@property (nonatomic, copy) NSString *title;
/** 内容*/
@property (nonatomic, copy) NSString *content;
/** 关注人数*/
@property (nonatomic, copy) NSString *followNums;
/** 参与话题*/
@property (nonatomic, copy) NSString *relatedTopics;
/** 注册时间*/
@property (nonatomic, copy) NSString *registerTime;
@end

//
//  HJCommentModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/15.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJCommentModel : NSObject
/** 消息类型*/
@property (nonatomic, copy) NSString *type;
/** 用户id*/
@property (nonatomic, copy) NSString *userId;
/** 头像*/
@property (nonatomic, copy) NSString *avatar;
/** 用户昵称*/
@property (nonatomic, copy) NSString *nickName;
/** 评论时间*/
@property (nonatomic, copy) NSString *commentTime;
/** 消息id*/
@property (nonatomic, copy) NSString *messageId;
/** 消息内容*/
@property (nonatomic, copy) NSString *messageContent;
/** 回复的消息id*/
@property (nonatomic, copy) NSString *replyMessageId;
/** 回复的用户昵称*/
@property (nonatomic, copy) NSString *replyNickName;
@end

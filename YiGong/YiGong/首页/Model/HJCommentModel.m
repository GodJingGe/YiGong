//
//  HJCommentModel.m
//  YiGong
//
//  Created by 黄靖 on 16/4/15.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJCommentModel.h"

@implementation HJCommentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
            @"userId":@"VAN_P_ID",
            @"avatar":@"VAN_P_AVATER",
            @"nickName":@"VAN_P_NAME",
            @"commentTime":@"VAN_UTIME",
            @"messageId":@"VANEW_ID",
            @"messageContent":@"VAN_CONTENT",
            @"replyMessageId":@"VAN_R_ID",
            @"replyNickName":@"VAN_R_PNAME",
            };
}
@end

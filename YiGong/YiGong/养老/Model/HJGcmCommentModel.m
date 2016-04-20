//
//  HJGcmCommentModel.m
//  YiGong
//
//  Created by 黄靖 on 16/4/18.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJGcmCommentModel.h"

@implementation HJGcmCommentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"userId":@"GMN_P_ID",
              @"avatar":@"GMN_P_AVATER",
              @"nickName":@"GMN_P_NAME",
              @"commentTime":@"GMN_UTIME",
              @"messageId":@"GMNEW_ID",
              @"messageContent":@"GMN_CONTENT",
              @"replyMessageId":@"GMN_R_ID",
              @"replyNickName":@"GMN_R_PNAME",
              };
}
@end

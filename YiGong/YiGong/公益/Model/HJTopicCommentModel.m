//
//  HJTopicCommentModel.m
//  YiGong
//
//  Created by 黄靖 on 16/4/18.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTopicCommentModel.h"

@implementation HJTopicCommentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"userId":@"VTN_P_ID",
              @"avatar":@"VTN_P_AVATER",
              @"nickName":@"VTN_P_NAME",
              @"commentTime":@"VTN_UTIME",
              @"messageId":@"VTNEW_ID",
              @"messageContent":@"VTN_CONTENT",
              @"replyMessageId":@"VTN_R_ID",
              @"replyNickName":@"VTN_R_PNAME",
              };
}
@end

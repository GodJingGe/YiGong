//
//  HJPartakeModel.m
//  YiGong
//
//  Created by 黄靖 on 16/4/14.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPartakeModel.h"

@implementation HJPartakeModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"avatar":@"VAE_USER_AVATER",
              @"nickName":@"VAE_USER_NAME",
              @"joinTime":@"VAE_UTIME",
              };
}
@end

//
//  HJPersonalModel.m
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPersonalModel.h"

@implementation HJPersonalModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"avatar":@"AVATER",
              @"nickName":@"USERNAME",
              @"sex":@"GENDER",
              @"birthday":@"BIRTH",
              @"phoneNum":@"PHONE",
              @"address":@"ADDRESS",
              @"career":@"JOB",
              @"signature":@"SIGN",
              @"teamId":@"vt_id",
              @"activity":@"n_va",
              @"donation":@"n_vd",
              @"attend":@"n_vt",
              };
}

@end

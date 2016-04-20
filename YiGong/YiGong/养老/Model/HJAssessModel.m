//
//  HJAssessModel.m
//  YiGong
//
//  Created by 黄靖 on 16/4/19.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJAssessModel.h"

@implementation HJAssessModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
               @"questionId":@"GMAITEM_ID",
               @"content":@"GMAI_CONTENT",
               @"score":@"GMAI_SCORE",
             
              };
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentScore = @(0);
    }
    return self;
}
@end

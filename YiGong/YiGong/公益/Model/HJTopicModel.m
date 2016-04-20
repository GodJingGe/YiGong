//
//  HJTopicModel.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTopicModel.h"

@implementation HJTopicModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"avatar":@"VTT_P_AVATER",
              @"title":@"VTT_TITLE",
              @"content":@"VTT_CONTENT",
              @"author":@"VTT_P_NAME",
              @"topicId":@"VTTHEME_ID",
              @"timeDate":@"VTT_UTIME",
              
              };
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.avatar = @"headp-80x80_03";
        self.title = @"本期活动：12日，关爱儿童健康讲座";
        self.content = @"本期活动：12日，关爱智障儿童健康讲座， 本次讲座将请来杭州第七人民医院的专家为 大家讲解，欢迎各位积极参加！";
        self.author = @"疯一样的男子";
        self.timeDate = @"刚刚 发布";
    }
    return self;
}
@end

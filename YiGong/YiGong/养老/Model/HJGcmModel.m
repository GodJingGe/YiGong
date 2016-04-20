//
//  HJGcmModel.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJGcmModel.h"

@implementation HJGcmModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"gcmName":@"GM_NAME",
              @"phoneNum":@"GM_TEL",
              @"gcmAddress":@"GM_ADDRESS",
              @"gcmSummary":@"GM_DESCRIPTION",
              @"gcmService":@"GM_FEEDESC",
              @"healthCare":@"GM_SERVEINFO",
              @"rctEquipment":@"GM_RECEIVE",
              @"gcmId":@"GM_ID",
              @"gcmAvatar":@"GM_AVATER",
              
              };
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gcmName = @"杭州爱康温馨家园养老中心";
        self.gcmAddress = @"杭州西湖区文三路327号";
        self.gcmSummary = @"杭州和睦老人公寓作为拱墅区老年公寓的二期工程，被列入“2013年拱墅区政府为民办实事十大工程”。公寓坐落在美丽的京杭大运河桥西边文岚街89号。";
        self.gcmService = @"杭州和睦老人公寓作为拱墅区老年公寓的二期工程，被列入“2013年拱墅区政府为民办实事十大工程”。公寓坐落在美丽的京杭大运河桥西边文岚街89号。";
        self.healthCare = @"杭州和睦老人公寓作为拱墅区老年公寓的二期工程，被列入“2013年拱墅区政府为民办实事十大工程”。公寓坐落在美丽的京杭大运河桥西边文岚街89号。";
        self.rctEquipment = @"杭州和睦老人公寓作为拱墅区老年公寓的二期工程，被列入“2013年拱墅区政府为民办实事十大工程”。公寓坐落在美丽的京杭大运河桥西边文岚街89号。";
    }
    return self;
}
@end

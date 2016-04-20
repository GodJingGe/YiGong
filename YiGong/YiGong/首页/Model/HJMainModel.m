//
//  HJMainModel.m
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJMainModel.h"

@implementation HJMainModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"activityId":@"VACTIVITY_ID",
              @"images":@"VAI_IMG_THEME",
              @"activityTime":@"VA_STIME",
              @"activityTitle":@"VA_TOPIC",
              @"activityAddress":@"VA_ADDRESS",
              @"activityPersons":@"VA_ENROLL",
              @"totalPersons":@"VA_ENROLL_M",
              @"teamName":@"VA_VT_NAME",
              @"activityContent":@"VA_CONTENT",
              @"activitySchedule":@"VA_SCHEDULE",
              
              };
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"images":@"HJMainImageModel"
             };
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDateFormatter * dfm = [[NSDateFormatter alloc]init];
        [dfm setDateFormat:@"MM-dd hh:mm"];
        NSString * dateStr = [dfm stringFromDate:[NSDate date]];
        self.activityTime = [NSString stringWithFormat:@"%@",dateStr];
        self.activityTitle = @"养老机构公益书画展";
        self.activityAddress = @"杭州下城区工人文化宫北2楼";
        self.activityPersons = @"21";
        self.totalPersons = @"31";
        self.activityState = @"1";
    }
    return self;
}


@end

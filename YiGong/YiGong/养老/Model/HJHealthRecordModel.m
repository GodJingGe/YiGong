//
//  HJHealthRecordModel.m
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJHealthRecordModel.h"

@implementation HJHealthRecordModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"type":@"ERH_GMH_TYPE",
              @"value":@"ERH_VALUE",
              @"timeDate":@"ERH_UTIME",
              
              };
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = @"1";
        self.value = @"123";
        self.timeDate = @"2015-12-25 14:00";
        
    }
    return self;
}
-(instancetype)initWithDict:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)healthWithDict:(NSDictionary*)dict{

    return [[self alloc]initWithDict:dict];
}

@end

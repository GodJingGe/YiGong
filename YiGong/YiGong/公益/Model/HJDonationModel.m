//
//  HJDonationModel.m
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJDonationModel.h"

@implementation HJDonationModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return  @{
              @"images":@"VD_IMGS",
              @"title":@"VD_TITLE",
              @"donattionId":@"VDONATION_ID",
              @"content":@"VD_CONTENT",
              @"donee":@"VD_TARGET",
              @"donor":@"VD_USER_NAME",
              @"donorId":@"VD_USER_ID",
              @"avatar":@"VD_USER_AVATER",
              @"timeDate":@"VD_UTIME",
              
              
              };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"images":@"HJDonationImageModel"
             };
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"老北京布鞋50双库存品捐赠";
        self.content = @"电子科技大学警用先进技术研究所所长殷光强告诉记者，这辆“神奇”的警车，是由电子科技大学与吉利集团、浙江省公安厅共同合作研发出的国内第一台标准制式的处警/巡逻车，也是我国目前唯一根据公安实际业务需求定制研发的一款集电气控制、无线通信、智能分析、信息采集等功能于一体的制式警车。";
        self.donee = @"捐赠对象：60岁以上老人及福利院";
        self.donor = @"疯一样的男子疯一样的男子";
        self.timeDate = @"刚刚 发布";
    }
    return self;
}
@end

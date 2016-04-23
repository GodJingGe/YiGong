//
//  HJCMWDonationViewController.h
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRootViewController.h"

@interface HJCMWDonationViewController : HJRootViewController
/** userid*/
@property (nonatomic, copy) NSString *userid;
/** 是否获取全部*/
@property(nonatomic, assign) BOOL isAll;
@end

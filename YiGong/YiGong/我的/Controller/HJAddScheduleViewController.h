//
//  HJAddScheduleViewController.h
//  YiGong
//
//  Created by 黄靖 on 16/4/19.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRootViewController.h"

@interface HJAddScheduleViewController : HJRootViewController
/** 完成回调*/
@property (nonatomic, copy) void (^completeAdd)(NSMutableArray *);
@end

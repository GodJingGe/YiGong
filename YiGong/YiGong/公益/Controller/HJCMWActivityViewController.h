//
//  HJCMWActivityViewController.h
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRootViewController.h"

@interface HJCMWActivityViewController : HJRootViewController
/** 隐藏导航栏*/
@property (nonatomic, copy) void(^hideNavigationBar)(BOOL);
@end

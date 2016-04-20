//
//  HJTabBar.h
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJTabBar : UITabBar
/** 自定义按钮*/
@property(nonatomic, strong) UIButton *tabBtn;
/** block*/
@property (nonatomic, copy) void (^onCLickBlock)(void);
@end

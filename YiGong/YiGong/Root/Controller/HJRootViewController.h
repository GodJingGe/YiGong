//
//  HJRootViewController.h
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJBackgroundView.h"

@interface HJRootViewController : UIViewController
/** 背景图*/
@property(nonatomic, strong) HJBackgroundView *bgView;
/** 提示框*/
@property(nonatomic, strong) MBProgressHUD *hud;

- (BOOL)isLogin;

-(UIImage *)ScreenShot;

- (void)showHudWithText:(NSString *)text;

- (void)showLoadingHudWithTitle:(NSString *)text OnView:(UIView *)view;

- (void)showHudWithText:(NSString *)text Time:(NSInteger)time OnView:(UIView *)view;
@end

//
//  HJLoginView.h
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJLoginView : UIView
/** 登录block*/
@property (nonatomic, copy) void (^loginBlock)(NSString *,NSString *);
/** 找回密码*/
@property (nonatomic, copy) void (^getPassWordBlock)(void);
/** 用户名*/
@property(nonatomic, strong) UIView *userView;
/** 密码*/
@property(nonatomic, strong) UIView *passwordView;
/** 用户名文本框*/
@property(nonatomic, strong) UITextField *usernameTF;
/** 密码文本框*/
@property(nonatomic, strong) UITextField *passwordTF;
/** 忘记密码*/
@property(nonatomic, strong) UIButton *getPDBtn;
/** 登录*/
@property(nonatomic, strong) UIButton *loginBtn;

/**
 *  初始化并进行登录
 *
 *  @param login 登录回调block
 *
 *  @return 当前视图
 */
- (instancetype)initWithLoginAction:(void(^)(NSString *username,NSString *password))login;
@end

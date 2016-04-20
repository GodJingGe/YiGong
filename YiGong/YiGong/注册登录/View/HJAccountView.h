//
//  HJAccountView.h
//  YiGong
//
//  Created by 黄靖 on 16/4/13.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJAccountView : UIView
#pragma mark --------------Property
/** 用户名*/
@property(nonatomic, strong) UIView *userView;
/** 验证码视图*/
@property(nonatomic, strong) UIView *codeView;
/** 密码*/
@property(nonatomic, strong) UIView *passwordView;
/** 用户名文本框*/
@property(nonatomic, strong) UITextField *usernameTF;
/** 验证码文本框*/
@property(nonatomic, strong) UITextField *codeTF;
/** 密码文本框*/
@property(nonatomic, strong) UITextField *passwordTF;
/** 验证码按钮*/
@property(nonatomic, strong) UIButton *codeBtn;
/** 下一步*/
@property(nonatomic, strong) UIButton *nextBtn;
/** 是否是注册*/
@property(nonatomic, assign) BOOL isRegister;

#pragma mark --------------Block
/** 下一步Block*/
@property (nonatomic, copy) void (^nextBlock)(NSString *,NSString *);
/** 找回密码*/
@property (nonatomic, copy) void (^getNewPassWord)(void);
/** 获取验证码Block*/
@property (nonatomic, copy) void (^getCodeBlock)(void);

#pragma mark --------------Method
- (void)getCode:(void (^)(void))code;
/**
 *  获得新密码
 *
 *  @param newPassWord 回调Block
 *
 *  @return self
 */
- (instancetype)initWithNewPassWordAction:(void(^)(void))newPassWord;

/**
 *  进行下一项注册
 *
 *  @param next 下一项注册回调
 *
 *  @return self
 */
- (instancetype)initWithNextAction:(void(^)(NSString *username,NSString *password))next;

@end

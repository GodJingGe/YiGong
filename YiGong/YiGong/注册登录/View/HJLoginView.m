//
//  HJLoginView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJLoginView.h"

@implementation HJLoginView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = BG_COLOR;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        [self createUI];
    }
    return self;
}
- (instancetype)initWithLoginAction:(void(^)(NSString *username,NSString *password))login{
    self = [super init];
    if (self) {
        self.backgroundColor = BG_COLOR;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        [self createUI];
        self.loginBlock = login;
    }
    return self;
}
- (void)createUI{
    _userView = [[UIView alloc]init];
    _userView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    _userView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_userView];
    
    _passwordView = [[UIView alloc]init];
    _passwordView.frame = CGRectMake(0, CGRectGetHeight(_userView.frame)+1, SCREEN_WIDTH, 60);
    _passwordView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_passwordView];
    
    // 设置占位文字的颜色
//    [_usernameTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //设置左视图
    _usernameTF = [[UITextField alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 30)];
    _usernameTF.placeholder = @"请输入手机号";
    _usernameTF.leftViewMode = UITextFieldViewModeAlways;
    _usernameTF.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"username"]];
//    _usernameTF.layer.borderWidth = 0.5;
//    _usernameTF.layer.borderColor = [UIColor whiteColor].CGColor;
//    _usernameTF.layer.cornerRadius = 5;
    [_userView addSubview:_usernameTF];
    
    
//    [_passwordTF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTF = [[UITextField alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH-30, 30)];
    _passwordTF.placeholder = @"密码至少输入6个字符";
    _passwordTF.leftViewMode = UITextFieldViewModeAlways;
    _passwordTF.secureTextEntry = YES;
    _passwordTF.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock"]];
//    _passwordTF.layer.borderWidth = 0.5;
//    _passwordTF.layer.borderColor = [UIColor whiteColor].CGColor;
//    _passwordTF.layer.cornerRadius = 5;
    [_passwordView addSubview:_passwordTF];
    
    _getPDBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect = _passwordView.frame;
    
    _getPDBtn.frame = CGRectMake(SCREEN_WIDTH - 115, rect.size.height + rect.origin.y, 100, 40);
    [_getPDBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    _getPDBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _getPDBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_getPDBtn setTitleColor:HJRGBA(205, 205, 205, 1.0) forState:UIControlStateNormal];
    [_getPDBtn addTarget:self action:@selector(getPassWordAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_getPDBtn];

    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(15, SCREEN_HEIGHT - 89 - 64, SCREEN_WIDTH - 30, 40);
    [_loginBtn setTitle:@"立刻登录" forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:THEME_COLOR] forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.layer.cornerRadius = 5;
    _loginBtn.clipsToBounds = YES;
    [self addSubview:_loginBtn];
}

- (void)getPassWordAction:(UIButton *)button{
    self.getPassWordBlock();
}

- (void)loginAction:(UIButton *)button{
    self.loginBlock(_usernameTF.text,_passwordTF.text);
}
@end

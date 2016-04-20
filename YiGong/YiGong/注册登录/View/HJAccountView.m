//
//  HJAccountView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/13.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJAccountView.h"

@implementation HJAccountView

- (instancetype)initWithNextAction:(void(^)(NSString *username,NSString *password))next{
    self = [super init];
    if (self) {
        self.backgroundColor = BG_COLOR;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        [self createUI];
        self.nextBlock = next;
    }
    return self;
}

- (instancetype)initWithNewPassWordAction:(void(^)(void))newPassWord
{
    self = [super init];
    if (self) {
        self.backgroundColor = BG_COLOR;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        [self createUI];
        self.getNewPassWord = newPassWord;
    }
    return self;
}

- (void)createUI{
    _userView = [[UIView alloc]init];
    _userView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    _userView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_userView];
    
    
    
    _codeView = [[UIView alloc]init];
    CGFloat codeY = CGRectGetHeight(_userView.frame) + 1;
    _codeView.frame = CGRectMake(0, codeY, SCREEN_WIDTH, 60);
    _codeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_codeView];
    
    _passwordView = [[UIView alloc]init];
    CGFloat passY = CGRectGetHeight(_codeView.frame) + _codeView.frame.origin.y + 1;
    _passwordView.frame = CGRectMake(0, passY, SCREEN_WIDTH, 60);
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
    
    _codeTF = [[UITextField alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 125, 30)];
    _codeTF.placeholder = @"输入验证码";
    _codeTF.leftViewMode = UITextFieldViewModeAlways;
    _codeTF.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mgs"]];
    [_codeView addSubview:_codeTF];
    
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
    
    _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _codeBtn.frame = CGRectMake(SCREEN_WIDTH - 110, 18, 95, 24);
    [_codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_codeBtn setBackgroundImage:[UIImage imageWithColor:THEME_COLOR] forState:UIControlStateNormal];
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_codeBtn addTarget:self action:@selector(verifyCode:) forControlEvents:UIControlEventTouchUpInside];
    _codeBtn.layer.cornerRadius = 12;
    _codeBtn.clipsToBounds = YES;
    [_codeView addSubview:_codeBtn];
   
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(15, SCREEN_HEIGHT - 89 - 64, SCREEN_WIDTH - 30, 40);
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setBackgroundImage:[UIImage imageWithColor:THEME_COLOR] forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    _nextBtn.layer.cornerRadius = 5;
    _nextBtn.clipsToBounds = YES;
    [self addSubview:_nextBtn];
}

// 获取Block回调
- (void)getCode:(void (^)(void))code{
    self.getCodeBlock = code;
}
// 下一步点击事件
- (void)nextAction:(UIButton *)button{
    
    if (_isRegister) {
        self.nextBlock(_usernameTF.text,_passwordTF.text);
    }else{
        self.getNewPassWord();
    }
    
}

// 获取验证码
- (void)verifyCode:(UIButton *)button{
    if (self.getCodeBlock) {
         self.getCodeBlock();
    }else{
        HJLog(@"没有实现Block");
    }
   
}
@end

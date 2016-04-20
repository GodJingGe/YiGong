//
//  HJAccountViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/13.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJAccountViewController.h"
#import "HJAvatarViewController.h"
#import "HJAccountView.h"

@interface HJAccountViewController ()
/** 账户*/
@property(nonatomic, strong) HJAccountView *accountView;

@end

@implementation HJAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)createUI{
    
    self.view.backgroundColor = BG_COLOR;
    
    if (_isRegister)
    {
        
        _accountView = [[HJAccountView alloc]initWithNextAction:^(NSString *username, NSString *password) {
            // 进行下一项注册
            HJLog(@"注册");
            
            HJAvatarViewController * avatarVC = [[HJAvatarViewController alloc]init];
            avatarVC.title = @"注册";
            avatarVC.model = self.model;
            [self.navigationController pushViewController:avatarVC animated:YES];
        }];
    }
    else
    {
        _accountView = [[HJAccountView alloc]initWithNewPassWordAction:^{
            HJLog(@"提交");
        }];
        [_accountView.nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    }
    _accountView.isRegister = _isRegister;
    [self.view addSubview:_accountView];
    
    [_accountView getCode:^{
        // 获取验证码
        
    }];
}

- (void)accountViewResignFirstResponder{
    [self.accountView.usernameTF resignFirstResponder];
    [self.accountView.codeTF resignFirstResponder];
    [self.accountView.passwordTF resignFirstResponder];
}

// 触摸事件 收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self accountViewResignFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.accountView.usernameTF becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self accountViewResignFirstResponder];
}


@end

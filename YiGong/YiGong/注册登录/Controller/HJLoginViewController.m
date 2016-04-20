//
//  HJLoginViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJLoginViewController.h"
#import "HJLoginView.h"
#import "HJRegisterViewController.h"
#import "HJAccountViewController.h"
@interface HJLoginViewController ()
/** 登录视图*/
@property(nonatomic, strong) HJLoginView * loginView;
@end

@implementation HJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createValue];
}
- (void)createValue{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(pushToRegisterVC)];
    
    self.view.backgroundColor = BG_COLOR;
    self.title = @"登录";
    
    // 初始化登录页面
    _loginView = [[HJLoginView alloc]initWithLoginAction:^(NSString *username, NSString *password) {
        HJLog(@"登录");
    }];
    __weak typeof(self) weakSelf = self;
    [_loginView setGetPassWordBlock:^{
        HJAccountViewController * accountVC = [[HJAccountViewController alloc]init];
        accountVC.title = @"找回密码";
        accountVC.isRegister = NO;
        [weakSelf.navigationController pushViewController:accountVC animated:YES];
    }];
    
    [self.view addSubview:_loginView];
}

// 跳转注册界面
- (void)pushToRegisterVC{
    
    HJRegisterViewController * registerVC = [[HJRegisterViewController alloc]init];
    registerVC.title = @"注册";
    [self.navigationController pushViewController:registerVC animated:YES];
    
}

- (void)loginViewResignFirstResponder{
    [_loginView.usernameTF resignFirstResponder];
    [_loginView.passwordTF resignFirstResponder];
}
// 触摸事件 收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self loginViewResignFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_loginView.usernameTF becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self loginViewResignFirstResponder];
}
@end

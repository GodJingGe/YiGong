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
#define LOGIN_URL @"login"

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
        
        if (username.length && password.length) {
            
            if ([self checkTel:username]) {
                HJRequestTool * tool = [[HJRequestTool alloc]init];
                NSString * url = [NSString stringWithFormat:COMMON_URL,LOGIN_URL];
                NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                [dic setObject:username forKey:@"tel"];
                [dic setObject:password forKey:@"pwd"];
                
                [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
                    NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    HJLog(@"%@",jsonData[@"result"]);
                    [self showHudWithText:jsonData[@"pd"][@"info"]];
                    
                    if ([jsonData[@"result"] isEqualToString:@"01"]) {
                        [[NSUserDefaults standardUserDefaults] setObject:jsonData[@"pd"][@"user"][@"USER_ID"] forKey:@"userid"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    
                } fail:^(NSError *error) {
                    [self showHudWithText:@"登录失败"];
                }];
                HJLog(@"登录");
            }
        }else{
            [self createAlertControllerWithTitle:@"用户名密码不能为空"];
        }
        
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
- (void)createAlertControllerWithTitle:(NSString *)title{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:^{
        _loginView.usernameTF.text = @"";
        _loginView.passwordTF.text = @"";
    }];
}

- (BOOL)checkTel:(NSString *)str

{
    
    if ([str length] == 0) {
        
        [self createAlertControllerWithTitle:@"手机号码不能为空"];
        return NO;
        
    }
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        [self createAlertControllerWithTitle:@"请输入正确的手机号"];
        
        return NO;
        
    }
    
    return YES;
    
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

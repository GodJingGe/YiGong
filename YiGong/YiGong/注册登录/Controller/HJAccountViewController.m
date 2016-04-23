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
#define CODE_URL @"usmsg"
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
             if (self.accountView.codeTF.text.length) {
//            if ([self.code isEqualToString:_accountView.codeTF.text]) {
            
                if (_accountView.passwordTF.text.length) {
                    if (_accountView.passwordTF.text.length >= 6) {
                        HJAvatarViewController * avatarVC = [[HJAvatarViewController alloc]init];
                        avatarVC.title = @"注册";
                        self.model.phoneNum = _accountView.usernameTF.text;
                        self.model.password = _accountView.passwordTF.text;
                        avatarVC.model = self.model;
                        [self.navigationController pushViewController:avatarVC animated:YES];
                    }else{
                        [self showHudWithText:@"密码长度小于6位"];
                    }
                    
                }else{
                    [self showHudWithText:@"密码不能为空"];
                }
                
                
            }else {
                [self showHudWithText:@"验证码不正确"];
            }
            
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
    
    __weak typeof(self) weakSelf = self;
    
//    [_accountView setGetCodeBlock:^{
//        
//        if ([weakSelf checkTel:weakSelf.accountView.usernameTF.text]) {
//            // 获取验证码
//            HJRequestTool * tool = [[HJRequestTool alloc]init];
//            NSString* url = [NSString stringWithFormat:COMMON_URL,CODE_URL];
//            NSDictionary * dic = [NSDictionary dictionaryWithObject:weakSelf.accountView.usernameTF.text forKey:@"tel"];
//            [tool postJSONWithUrl:url parameters:dic success:^(id responseObject) {
//                NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                HJLog(@"%@",jsonData);
//                weakSelf.code = jsonData[@"pd"][@"code"];
//                [weakSelf showHudWithText:jsonData[@"pd"][@"status"][@"statusMsg"]];
//                weakSelf.model.phoneNum = dic[@"tel"];
//            } fail:^(NSError *error) {
//                [weakSelf showHudWithText:@"获取失败，请重试"];
//            }];
//        }
//    }];
    
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
- (void)createAlertControllerWithTitle:(NSString *)title{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
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

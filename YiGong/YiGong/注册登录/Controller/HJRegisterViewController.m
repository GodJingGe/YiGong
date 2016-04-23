//
//  HJRegisterViewController.m
//  YiGong
//
//  Created by 黄靖 on 16/4/13.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRegisterViewController.h"
#import "HJAccountViewController.h"
#import "HJRegisterNickNameView.h"

@interface HJRegisterViewController ()
/** 昵称*/
@property(nonatomic, strong) HJRegisterNickNameView *nickNameView;
/** 模型*/
@property(nonatomic, strong) HJRegisterModel *model;
@end

@implementation HJRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
- (void)createUI{
    
    self.view.backgroundColor = BG_COLOR;
    
    _model = [[HJRegisterModel alloc]init];
    
    _nickNameView = [[HJRegisterNickNameView alloc]initWithNextAction:^(NSString *nickName) {
        if (nickName.length && nickName.length < 14) {
            _model.nickName = nickName;
            HJAccountViewController * accountVC = [[HJAccountViewController alloc]init];
            accountVC.title = @"注册";
            accountVC.isRegister = YES;
            accountVC.model = _model;
            [self.navigationController pushViewController:accountVC animated:YES];
            
        }else if (!nickName.length){
            [self createAlertWithTitle:@"昵称不能为空"];
        }else{
            [self createAlertWithTitle:@"昵称长度过长"];
        }
        
    }];
    [self.view addSubview:_nickNameView];
}

- (void)createAlertWithTitle:(NSString *)title{
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:okAction];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}
// 触摸事件 收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nickNameView.nickNameTF resignFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.nickNameView.nickNameTF becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.nickNameView.nickNameTF resignFirstResponder];
}

@end

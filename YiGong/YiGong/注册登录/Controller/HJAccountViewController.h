//
//  HJAccountViewController.h
//  YiGong
//
//  Created by 黄靖 on 16/4/13.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRootViewController.h"
#import "HJRegisterModel.h"
@interface HJAccountViewController : HJRootViewController
/** 模型*/
@property(nonatomic, strong) HJRegisterModel *model;
/** 验证码*/
@property (nonatomic, copy) NSString *code;
/** 是否是注册*/
@property(nonatomic, assign) BOOL isRegister;
@end

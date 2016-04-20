//
//  HJRegisterModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/13.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJRegisterModel : NSObject
/** 昵称*/
@property (nonatomic, copy) NSString *nickName;
/** 用户名*/
@property (nonatomic, copy) NSString *userName;
/** 密码*/
@property (nonatomic, copy) NSString *password;
/** 手机号*/
@property (nonatomic, copy) NSString *phoneNum;
/** 头像*/
@property(nonatomic, strong) UIImage *avatar;
@end

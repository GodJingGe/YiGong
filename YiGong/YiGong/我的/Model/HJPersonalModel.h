//
//  HJPersonalModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJPersonalModel : NSObject
/** 修改的头像*/
@property(nonatomic, strong) UIImage *newavatar;
/** 头像*/
@property (nonatomic, copy) NSString *avatar;
/** 昵称*/
@property (nonatomic, copy) NSString *nickName;
/** 性别*/
@property (nonatomic, copy) NSString *sex;
/** 出生年月*/
@property (nonatomic, copy) NSString *birthday;
/** 手机号码*/
@property (nonatomic, copy) NSString *phoneNum;
/** 通讯地址*/
@property (nonatomic, copy) NSString *address;
/** 从事工作*/
@property (nonatomic, copy) NSString *career;
/** 个性签名*/
@property (nonatomic, copy) NSString *signature;
/** 团队Id*/
@property (nonatomic, copy) NSString *teamId;
/** 参与活动*/
@property (nonatomic, copy) NSString *activity;
/** 我的捐赠*/
@property (nonatomic, copy) NSString *donation;
/** 我的关注*/
@property (nonatomic, copy) NSString *attend;

@end

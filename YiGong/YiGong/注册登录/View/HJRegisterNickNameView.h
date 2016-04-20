//
//  HJRegisterNickNameView.h
//  YiGong
//
//  Created by 黄靖 on 16/4/13.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJRegisterNickNameView : UIView
/** 跳转*/
@property (nonatomic, copy) void (^nextBlock)(NSString *);
/** 用户名*/
@property(nonatomic, strong) UIView *userView;
/** 用户名文本框*/
@property(nonatomic, strong) UITextField *nickNameTF;
/** 登录*/
@property(nonatomic, strong) UIButton *nextBtn;


- (instancetype)initWithNextAction:(void(^)(NSString *nickName))next;
@end

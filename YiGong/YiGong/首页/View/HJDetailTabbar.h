//
//  HJDetailTabbar.h
//  YiGong
//
//  Created by 黄靖 on 16/4/17.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDetailTabbar : UITabBar
/** 评论Block*/
@property (nonatomic, copy) void (^commentBlock)(void);
/** 报名*/
@property (nonatomic, copy) void (^takePartInBlock)(void);
/** 评论*/
@property(nonatomic, strong) UIButton *commentBtn;
/** 报名*/
@property(nonatomic, strong) UIButton *partakeBtn;

- (instancetype)initWithCommentAction:(void(^)(void))comment andTakePartInAction:(void(^)(void))join;
@end

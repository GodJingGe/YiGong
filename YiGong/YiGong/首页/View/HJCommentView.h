//
//  HJCommentView.h
//  YiGong
//
//  Created by 黄靖 on 16/4/1.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJCommentView : UIView
/** 头像*/
@property(nonatomic, strong) UIImageView *iconImageView;
/** 昵称*/
@property(nonatomic, strong) UILabel *nickNameLabel;
/** 评论内容*/
@property(nonatomic, strong) UITextView *commentTextView;
/** 评论时间*/
@property(nonatomic, strong) UILabel *commentTimeLabel;
/** 回复评论*/
@property(nonatomic, strong) UIButton *replyBtn;

/** 评论回调*/
@property (nonatomic, copy) void (^replyBlock)(void);

- (void)resetFrame;
@end

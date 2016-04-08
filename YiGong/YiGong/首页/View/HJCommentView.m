//
//  HJCommentView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/1.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJCommentView.h"

@implementation HJCommentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat height  = _commentTextView.frame.origin.y + _commentTextView.frame.size.height + 45;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        [self addSubview:self.replyBtn];
    }
    return self;
}

- (void)resetFrame{
    _commentTextView.frame = CGRectMake(70, 45, SCREEN_WIDTH - 110, _commentTextView.contentSize.height + 10);
    CGFloat y  = _commentTextView.frame.origin.y + _commentTextView.frame.size.height + 10;
    _commentTimeLabel.frame = CGRectMake(70, y, SCREEN_WIDTH/3, 15);
    _replyBtn.frame = CGRectMake(SCREEN_WIDTH - 40, y, 25, 25);
    CGFloat height  = _commentTextView.frame.origin.y + _commentTextView.frame.size.height + 45;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
}

/** 回复评论*/
- (UIButton *)replyBtn{
    if (!_replyBtn) {
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat y  = _commentTextView.frame.origin.y + _commentTextView.frame.size.height + 10;
        _replyBtn.frame = CGRectMake(SCREEN_WIDTH - 40, y, 25, 25);
        [_replyBtn setBackgroundImage:[UIImage imageNamed:@"Signet"] forState:UIControlStateNormal];
    }
    return _replyBtn;
}

/** 头像*/
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.frame = CGRectMake(15, 18, 40, 40);
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

/** 昵称*/
- (UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc]init];
        _nickNameLabel.frame = CGRectMake(70, 15, SCREEN_WIDTH/3, 20);
        _nickNameLabel.font = [UIFont systemFontOfSize:14];
        _nickNameLabel.textColor = HJRGBA(100, 100, 100, 1.0);
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_nickNameLabel];
    }
    return _nickNameLabel;
}

/** 评论内容*/
- (UITextView *)commentTextView{
    if (!_commentTextView) {
        _commentTextView = [[UITextView alloc]init];
        _commentTextView.frame = CGRectMake(70, 45, SCREEN_WIDTH - 110, 30);
        _commentTextView.textColor = HJRGBA(170, 170, 170, 1.0);
        _commentTextView.font = [UIFont systemFontOfSize:14];
        _commentTextView.editable = NO;
        [self addSubview:_commentTextView];
    }
    return _commentTextView;
}

/** 评论时间*/
- (UILabel *)commentTimeLabel{
    if (!_commentTimeLabel) {
        _commentTimeLabel = [[UILabel alloc]init];
        CGFloat y  = _commentTextView.frame.origin.y + _commentTextView.frame.size.height + 10;
        _commentTimeLabel.frame = CGRectMake(70, y, SCREEN_WIDTH/3, 15);
        _commentTimeLabel.font = [UIFont systemFontOfSize:12];
        _commentTimeLabel.textColor = HJRGBA(170, 170, 170, 1.0);
        _commentTimeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_commentTimeLabel];
    }
    return _commentTimeLabel;
}


@end

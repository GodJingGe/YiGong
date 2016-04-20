//
//  HJDetailTabbar.m
//  YiGong
//
//  Created by 黄靖 on 16/4/17.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJDetailTabbar.h"

@implementation HJDetailTabbar

- (instancetype)initWithCommentAction:(void(^)(void))comment andTakePartInAction:(void(^)(void))join
{
    self = [super init];
    if (self) {
        self.commentBlock = comment;
        self.takePartInBlock = join;
        [self addSubview:self.commentBtn];
        
        [self addSubview:self.partakeBtn];
    }
    return self;
}

- (UIButton *)partakeBtn{
    if (!_partakeBtn) {
        _partakeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _partakeBtn.frame = CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 49);
        _partakeBtn.backgroundColor = HJRGBA(234, 83, 97, 1.0);
        [_partakeBtn setTitle:@"立刻报名" forState:UIControlStateNormal];
        [_partakeBtn addTarget:self action:@selector(partakeActivityAction:) forControlEvents:UIControlEventTouchUpInside];
        _partakeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_partakeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _partakeBtn;
}
- (UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 49);
        _commentBtn.backgroundColor = HJRGBA(248, 97, 111, 1.0);
        [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_commentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _commentBtn;
}

- (void)commentAction:(UIButton *)button{
    self.commentBlock();
}
- (void)partakeActivityAction:(UIButton *)button{
    self.takePartInBlock();
}

@end

//
//  HJActIntroduceView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/1.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJActIntroduceView.h"

@implementation HJActIntroduceView
- (UITextView *)actTextView{
    if (!_actTextView) {
        _actTextView = [[UITextView alloc]init];
        _actTextView.frame = CGRectMake(15, 0, SCREEN_WIDTH, 100);
        _actTextView.textColor = HJRGBA(170, 170, 170, 1.0);
        _actTextView.font = [UIFont systemFontOfSize:16];
        _actTextView.editable = NO;
        [self addSubview:_actTextView];
    }
    return _actTextView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end

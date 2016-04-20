//
//  HJBackgroundView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/9.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJBackgroundView.h"

@implementation HJBackgroundView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.bgImageView];
        self.frame = CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return self;
}
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _bgImageView;
}
@end

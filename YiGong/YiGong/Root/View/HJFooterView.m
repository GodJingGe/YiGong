//
//  HJFooterView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJFooterView.h"

@implementation HJFooterView

- (instancetype)initWithAction:(void(^)(void))handler
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
        self.clickBlock = handler;
    }
    return self;
}

- (UIButton *)footerBtn{
    if (!_footerBtn) {
        _footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _footerBtn.frame = CGRectMake(15, 20, SCREEN_WIDTH - 30, 40);
        [_footerBtn setBackgroundImage:[UIImage imageWithColor:HJRGBA(248, 97, 111, 1.0)] forState:UIControlStateNormal];
        [_footerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_footerBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _footerBtn.layer.cornerRadius = 5;
        _footerBtn.clipsToBounds = YES;
        [self addSubview:_footerBtn];
    }
    return _footerBtn;
}

- (void)clickAction:(UIButton *)button{
    self.clickBlock();
}
@end

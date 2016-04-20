//
//  HJTabBar.m
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTabBar.h"

@implementation HJTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 64-49, SCREEN_WIDTH, 49);
        self.backgroundColor = THEME_COLOR;
    }
    return self;
}

-(UIButton *)tabBtn{
    if (!_tabBtn) {
        _tabBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tabBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);
        [_tabBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_tabBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_tabBtn];
    }
    return _tabBtn;
}
- (void)onClick:(UIButton *)button{
    self.onCLickBlock();
}
@end

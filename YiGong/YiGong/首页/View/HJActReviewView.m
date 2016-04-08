//
//  HJActReviewView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/1.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJActReviewView.h"

@implementation HJActReviewView
-(UIButton *)actPicBtn{
    if (!_actPicBtn) {
        _actPicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _actPicBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        [_actPicBtn addTarget:self action:@selector(browserPic:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_actPicBtn];
        [self addSubview:self.titleView];
    }
    return _actPicBtn;
}

- (UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]init];
        _titleView.frame = CGRectMake(0, self.frame.size.height - 50, SCREEN_WIDTH, 50);
        _titleView.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.1 brightness:0.1 alpha:0.5];
        [_titleView addSubview:self.titleLabel];
    }
    return _titleView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(15, 0, SCREEN_WIDTH - 60, 50);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
#pragma mark --------------ClickAction
- (void)browserPic:(UIButton *)button{
    
}
@end

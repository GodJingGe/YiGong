//
//  HJTeamItemView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTeamItemView.h"

@implementation HJTeamItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
        self.frame = CGRectMake(0, 195, SCREEN_WIDTH/3, 75);
    }
    return self;
}
- (void)createUI{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(0, 45, SCREEN_WIDTH/3, 15);
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc]init];
    _detailLabel.frame = CGRectMake(0, 15, SCREEN_WIDTH/3, 20);
    _detailLabel.font = [UIFont systemFontOfSize:20];
    _detailLabel.textColor = [UIColor whiteColor];
    _detailLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_detailLabel];
    
    _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clickBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, 75);
    [self addSubview:_clickBtn];
}
@end

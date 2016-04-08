//
//  HJServiceSummary.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJServiceSummary.h"

@implementation HJServiceSummary

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 76);
        self.frame = rect;
        [self createUI];
    }
    return self;
}
- (void)createUI{
    /** 标题图标*/
    _titleImageV = [[UIImageView alloc]init];
    _titleImageV.frame = CGRectMake(15, 15, 18, 18);
    _titleImageV.image = [UIImage imageNamed:@"Star"];
    [self addSubview:_titleImageV];
    /** 位置图标*/
    _locationImageV = [[UIImageView alloc]init];
    _locationImageV.frame = CGRectMake(15, 43, 18, 18);
    _locationImageV.image = [UIImage imageNamed:@"site"];
    [self addSubview:_locationImageV];
    /** 标题*/
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(43, 15, SCREEN_WIDTH/2*3, 18);
    _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    /** 位置*/
    _locationLabel = [[UILabel alloc]init];
    _locationLabel.frame = CGRectMake(43, 45, SCREEN_WIDTH/2, 18);
    _locationLabel.textColor = HJRGBA(170, 170, 170, 1.0);
    _locationLabel.font = [UIFont systemFontOfSize:14];
    _locationLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_locationLabel];
    /** 拨打电话*/
    _callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _callBtn.frame = CGRectMake(SCREEN_WIDTH - 57, 16, 42, 42);
    [_callBtn setBackgroundImage:[UIImage imageNamed:@"iphone"] forState:UIControlStateNormal];
    [self addSubview:_callBtn];
    
}

- (void)setModel:(HJGcmModel *)model{
    _model = model;
    _titleLabel.text = model.gcmName;
    _locationLabel.text = model.gcmAddress;
    
}

@end

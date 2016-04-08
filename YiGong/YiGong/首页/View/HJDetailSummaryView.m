//
//  HJDetailSummaryView.m
//  YiGong
//
//  Created by 黄靖 on 16/3/31.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJDetailSummaryView.h"

@implementation HJDetailSummaryView


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
    _titleLabel.frame = CGRectMake(43, 15, SCREEN_WIDTH/2, 18);
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
    
    /** 活动时间*/
    _dateTimeLabel = [[UILabel alloc]init];
    _dateTimeLabel.frame = CGRectMake(SCREEN_WIDTH *2/3 , 13, SCREEN_WIDTH/3 - 15, 17);
    _dateTimeLabel.textColor = HJRGBA(60, 206, 132, 1.0);
    _dateTimeLabel.font = [UIFont systemFontOfSize:12];
    _dateTimeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_dateTimeLabel];
    
    /** 活动状态*/
    _stateView = [[UIImageView alloc]init];
    _stateView.frame = CGRectMake(SCREEN_WIDTH - 85 , 35, 70, 25);
    [self addSubview:_stateView];

}

- (void)setModel:(HJMainModel *)model{
    _model = model;
    _titleLabel.text = model.activityTitle;
    _locationLabel.text = model.activityAddress;
    _dateTimeLabel.text = model.activityTime;
    if ([model.activityState isEqualToString:@"1"])
        _stateView.image = [UIImage imageNamed:@"processing"];
    else _stateView.image = [UIImage imageNamed:@"over"];
}
@end

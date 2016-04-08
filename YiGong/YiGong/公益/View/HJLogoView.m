//
//  HJLogoView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJLogoView.h"

@implementation HJLogoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
        self.frame = CGRectMake((SCREEN_WIDTH - 80)/2, 70, 80, 80);
    }
    return self;
}
- (void)createUI{
    _logoBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    _logoBgView.backgroundColor = HJRGBA(255, 255, 255, 0.2);
    _logoBgView.layer.cornerRadius = _logoBgView.frame.size.width/2;
    _logoBgView.clipsToBounds = YES;
    [self addSubview:_logoBgView];
    
    _teamIconImageV = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
    _teamIconImageV.image = [UIImage imageNamed:@"headp-80x80_01"];
    _teamIconImageV.layer.cornerRadius = _teamIconImageV.frame.size.width/2;
    _teamIconImageV.clipsToBounds = YES;
    [_logoBgView addSubview:_teamIconImageV];
    
    _followImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"follower"]];
    _followImageV.frame = CGRectMake(50, 60, 20, 20);
    [self addSubview:_followImageV];
}
@end

//
//  HJPersonalCenterView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPersonalCenterView.h"

@implementation HJPersonalCenterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}
- (UITapGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePersonalInfo)];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
    }
    return _tap;
}
- (void)createUI{
    _backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270)];
    _backgroundView.image = [UIImage imageNamed:@"Common"];
    [self addSubview:_backgroundView];
    
    _logoView = [[HJLogoView alloc]init];
    _logoView.followImageV.image = [UIImage imageNamed:@"Modify"];
    [self addSubview:_logoView];
    [_logoView addGestureRecognizer:self.tap];
    self.frame = self.backgroundView.bounds;
    
    _teamNameLabel = [[UILabel alloc]init];
    _teamNameLabel.frame = CGRectMake(0, 165, SCREEN_WIDTH, 25);
    _teamNameLabel.font = [UIFont systemFontOfSize:16];
    _teamNameLabel.textColor = [UIColor whiteColor];
    _teamNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_teamNameLabel];
    
    _followView = [[HJTeamItemView alloc]init];
    _followView.frame = CGRectMake(0, 195, SCREEN_WIDTH/3, 75);
    _followView.titleLabel.text = @"参与活动";
    _followView.clickBtn.tag = 10;
    [_followView.clickBtn addTarget:self action:@selector(pushToNextVC:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_followView];
    
    _releatedTopicView = [[HJTeamItemView alloc]init];
    _releatedTopicView.frame = CGRectMake(SCREEN_WIDTH/3, 195, SCREEN_WIDTH/3, 75);
    _releatedTopicView.titleLabel.text = @"我的捐赠";
    _releatedTopicView.clickBtn.tag = 11;
    [_releatedTopicView.clickBtn addTarget:self action:@selector(pushToNextVC:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_releatedTopicView];
    
    _registerView = [[HJTeamItemView alloc]init];
    _registerView.frame = CGRectMake(SCREEN_WIDTH * 2/3, 195, SCREEN_WIDTH/3, 75);
    _registerView.titleLabel.text = @"我的关注";
    _registerView.clickBtn.tag = 12;
    [_registerView.clickBtn addTarget:self action:@selector(pushToNextVC:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_registerView];
    
}
- (void)changePersonalInfo{
    self.pushToPersonalInfoVCBlock();
}
- (void)pushToNextVC:(UIButton *)button{
   // 视图跳转
    self.pushToNextVCBlock(button.tag);
}


@end

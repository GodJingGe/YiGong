//
//  HJTeamCenterView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTeamCenterView.h"

@implementation HJTeamCenterView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    _backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270)];
    _backgroundView.image = [UIImage imageNamed:@"Common"];
    [self addSubview:_backgroundView];
    
    _logoView = [[HJLogoView alloc]init];
    [self addSubview:_logoView];
    
    _teamNameLabel = [[UILabel alloc]init];
    _teamNameLabel.frame = CGRectMake(0, 165, SCREEN_WIDTH, 25);
    _teamNameLabel.font = [UIFont systemFontOfSize:16];
    _teamNameLabel.textColor = [UIColor whiteColor];
    _teamNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_teamNameLabel];
    
    _followView = [[HJTeamItemView alloc]init];
    _followView.frame = CGRectMake(0, 195, SCREEN_WIDTH/3, 75);
    _followView.titleLabel.text = @"关注人数";
    [self addSubview:_followView];
    
    _releatedTopicView = [[HJTeamItemView alloc]init];
    _releatedTopicView.frame = CGRectMake(SCREEN_WIDTH/3, 195, SCREEN_WIDTH/3, 75);
    _releatedTopicView.titleLabel.text = @"参与话题";
    [_releatedTopicView.clickBtn addTarget:self action:@selector(pushToTopicsVCAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_releatedTopicView];
    
    _registerView = [[HJTeamItemView alloc]init];
    _registerView.frame = CGRectMake(SCREEN_WIDTH * 2/3, 195, SCREEN_WIDTH/3, 75);
    _registerView.titleLabel.text = @"注册时间";
    [self addSubview:_registerView];
    
    _detailTextV = [[UITextView alloc]init];
    _detailTextV.frame = CGRectMake(15, 280, SCREEN_WIDTH - 15, SCREEN_HEIGHT - 280);
    _detailTextV.editable = NO;
    [self addSubview:_detailTextV];
}

- (void)setModel:(HJTeamModel *)model{
    _model = model;
    _teamNameLabel.text = model.teamName;
    _followView.detailLabel.text = model.followNums;
    _releatedTopicView.detailLabel.text = model.relatedTopics;
    _registerView.detailLabel.text = model.registerTime;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:HJRGBA(170, 170, 170, 1.0)
                                 };
    _detailTextV.attributedText = [[NSAttributedString alloc] initWithString:model.content attributes:attributes];
    
}
#pragma mark --------------ClickAction
- (void)pushToTopicsVCAction:(UIButton *)button{
    HJLog(@"跳转");
    self.pushToTopicsVCBlock();
}
@end

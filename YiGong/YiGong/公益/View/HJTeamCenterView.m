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
    
    self.backgroundColor = [UIColor whiteColor];
    
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
    [self addSubview:_releatedTopicView];
    
    _registerView = [[HJTeamItemView alloc]init];
    _registerView.frame = CGRectMake(SCREEN_WIDTH * 2/3, 195, SCREEN_WIDTH/3, 75);
    _registerView.titleLabel.text = @"注册时间";
    [self addSubview:_registerView];
    
    _detailView = [[UIView alloc]init];
    _detailView.frame = CGRectMake(0, 270, SCREEN_WIDTH, SCREEN_HEIGHT - 270-49);
    _detailView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_detailView];
    
    _detailTextV = [[UITextView alloc]init];
    _detailTextV.frame = CGRectMake(15, 10, SCREEN_WIDTH - 15, SCREEN_HEIGHT - 280-49);
    _detailTextV.editable = NO;
    [_detailView addSubview:_detailTextV];
}

- (void)setModel:(HJTeamModel *)model{
    _model = model;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,model.teamIcon]];
    [_logoView.teamIconImageV sd_setImageWithURL:url];
//    if ([model.states isEqualToString:@"1"]) {
//       [_logoView.followImageV setHidden:YES];
//    }
    _teamNameLabel.text = model.teamName;
    _followView.detailLabel.text = model.followNums;
    _releatedTopicView.detailLabel.text = model.relatedTopics;
    _registerView.detailLabel.text = [self getFormaterTime:model.registerTime];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:HJRGBA(170, 170, 170, 1.0)
                                 };
    _detailTextV.attributedText = [[NSAttributedString alloc] initWithString:model.content attributes:attributes];
    
}
- (NSString *)getFormaterTime:(NSString *)time{
    NSArray * timeArr = [time componentsSeparatedByString:@"-"];
    NSString * year = [timeArr[0] substringFromIndex:2];
    NSString * timeStr = [NSString stringWithFormat:@"%@.%@",year,timeArr[1]];
    return timeStr;
}
@end

//
//  HJTeamTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTeamTableViewCell.h"

@implementation HJTeamTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self createUI];
    }
    return self;
}
- (void)createUI{
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.frame = CGRectMake(15, 15, 60, 60);
    _iconImageView.layer.cornerRadius = 4;
    _iconImageView.layer.borderWidth = 0.5;
    _iconImageView.layer.borderColor = HJRGBA(219, 219, 219, 1.0).CGColor;
    _iconImageView.clipsToBounds = YES;
    [self addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(90, 15, SCREEN_WIDTH - 85, 20);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
    _titleLabel.text = @"沐沐沐雅";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc]init];
    _detailLabel.frame = CGRectMake(90, 40, SCREEN_WIDTH - 120, 45);
    _detailLabel.font = [UIFont systemFontOfSize:14];
    _detailLabel.textColor = HJRGBA(170, 170, 170, 1.0);
    _detailLabel.text = @"刚刚 参加了报名";
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    _detailLabel.numberOfLines = 2;
    [self addSubview:_detailLabel];
}

- (void)setModel:(HJTeamModel *)model{
    
    _model = model;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,model.teamIcon]];
    HJLog(@"%@",url);
    [_iconImageView sd_setImageWithURL:url];
//    _iconImageView.image = [UIImage imageNamed:model.teamIcon];
    _titleLabel.text = model.teamName;
    _detailLabel.text = model.content;
    
}

@end

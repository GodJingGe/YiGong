//
//  HJPartakeTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/1.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPartakeTableViewCell.h"

@implementation HJPartakeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}
- (void)createUI{
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.frame = CGRectMake(15, 18, 40, 40);
    _iconImageView.image = [UIImage imageNamed:@"headp-80x80_01"];
    [self addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(70, 15, SCREEN_WIDTH - 85, 20);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
    _titleLabel.text = @"沐沐沐雅";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc]init];
    _detailLabel.frame = CGRectMake(70, 40, SCREEN_WIDTH - 85, 20);
    _detailLabel.font = [UIFont systemFontOfSize:14];
    _detailLabel.textColor = HJRGBA(170, 170, 170, 1.0);
    _detailLabel.text = @"刚刚 参加了报名";
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_detailLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

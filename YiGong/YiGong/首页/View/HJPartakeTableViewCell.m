//
//  HJPartakeTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/1.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPartakeTableViewCell.h"
#define IMAGE_SIZE 40
#define CORNERRADIUS 20
@implementation HJPartakeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.frame = CGRectMake(15, 18, IMAGE_SIZE, IMAGE_SIZE);
        _iconImageView.image = [UIImage imageNamed:@"headp-80x80_01"];
        _iconImageView.layer.cornerRadius = CORNERRADIUS;
        _iconImageView.clipsToBounds = YES;
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(70, 15, SCREEN_WIDTH - 85, 20);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
        _titleLabel.text = @"沐沐沐雅";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.frame = CGRectMake(70, 40, SCREEN_WIDTH - 85, 20);
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = HJRGBA(170, 170, 170, 1.0);
        _detailLabel.text = @"刚刚 参加了报名";
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (void)setModel:(HJPartakeModel *)model{
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,model.avatar]];
    [self.iconImageView sd_setImageWithURL:url];
    self.titleLabel.text = model.nickName;
    self.detailLabel.text = model.joinTime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

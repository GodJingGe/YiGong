//
//  HJDonationTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJDonationTableViewCell.h"

@implementation HJDonationTableViewCell

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
        _iconImageView.frame = CGRectMake(15, 15, 60, 60);
        _iconImageView.layer.cornerRadius = 4;
        _iconImageView.layer.borderWidth = 0.5;
        _iconImageView.layer.borderColor = HJRGBA(219, 219, 219, 1.0).CGColor;
        _iconImageView.clipsToBounds = YES;
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(90, 15, SCREEN_WIDTH - 85, 20);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
        _titleLabel.text = @"沐沐沐雅";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)donneLabel{
    if (!_donneLabel) {
        _donneLabel = [[UILabel alloc]init];
        _donneLabel.frame = CGRectMake(90, 40, SCREEN_WIDTH - 120, 20);
        _donneLabel.font = [UIFont systemFontOfSize:14];
        _donneLabel.textColor = HJRGBA(60, 206, 132, 1.0);
        _donneLabel.text = @"刚刚 参加了报名";
        _donneLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_donneLabel];
    }
    return _donneLabel;
}

- (UILabel *)donorLabel{
    if (!_donorLabel) {
        _donorLabel = [[UILabel alloc]init];
        _donorLabel.frame = CGRectMake(90, 60, SCREEN_WIDTH - 120, 20);
        _donorLabel.font = [UIFont systemFontOfSize:12];
        _donorLabel.textColor = HJRGBA(204, 204, 204, 1.0);
        _donorLabel.textAlignment = NSTextAlignmentLeft;
        _donorLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _donorLabel.numberOfLines = 0;
        [self addSubview:_donorLabel];
    }
    return _donorLabel;
}

- (UILabel *)timeDateLabel{
    if (!_timeDateLabel) {
        _timeDateLabel = [[UILabel alloc]init];
        _timeDateLabel.frame = CGRectMake(90, 60, SCREEN_WIDTH - 120, 20);
        _timeDateLabel.font = [UIFont systemFontOfSize:12];
        _timeDateLabel.textColor = HJRGBA(204, 204, 204, 1.0);
        _timeDateLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_timeDateLabel];
    }
    return _timeDateLabel;
}

/** 评论内容*/
- (UITextView *)detailTextView{
    if (!_detailTextView) {
        _detailTextView = [[UITextView alloc]init];
        _detailTextView.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, 30);
        _detailTextView.textColor = HJRGBA(170, 170, 170, 1.0);
        _detailTextView.font = [UIFont systemFontOfSize:14];
        _detailTextView.editable = NO;
        [self addSubview:_detailTextView];
    }
    return _detailTextView;
}

- (void)setModel:(HJDonationModel *)model{
    
    _model = model;
    HJLog(@"%@",model.images);
    if (!_indexPath.section) {
        
        if (_isAvatar) {
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,model.avatar]];
            [self.iconImageView sd_setImageWithURL:url];
        }else if (model.images.count){
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,model.images[0].imageUrl]];
            [self.iconImageView sd_setImageWithURL:url];
        }
        
        self.titleLabel.text = model.title;
        self.donneLabel.text = model.donee;
        self.donorLabel.text = model.donor;
        [self.donorLabel sizeToFit];
        self.donorLabel.frame = CGRectMake(90, 60, _donorLabel.frame.size.width, 20);
        self.timeDateLabel.text = model.timeDate;
        //    _timeDateLabel.frame = CGRectMake(SCREEN_WIDTH * 2/3 - 30, 60, SCREEN_WIDTH/3, 20);
        CGFloat x = _donorLabel.frame.origin.x + _donorLabel.frame.size.width + 15;
        self.timeDateLabel.frame = CGRectMake(x, 60, SCREEN_WIDTH/3, 20);
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90);
        
    }else{
        self.detailTextView.text = model.content;
        self.detailTextView.frame = CGRectMake(15, 0, SCREEN_WIDTH - 15, self.detailTextView.contentSize.height + 10);
        self.frame = self.detailTextView.frame;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

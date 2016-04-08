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
    
    _donneLabel = [[UILabel alloc]init];
    _donneLabel.frame = CGRectMake(90, 40, SCREEN_WIDTH - 120, 20);
    _donneLabel.font = [UIFont systemFontOfSize:14];
    _donneLabel.textColor = HJRGBA(60, 206, 132, 1.0);
    _donneLabel.text = @"刚刚 参加了报名";
    _donneLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_donneLabel];
    
    _donorLabel = [[UILabel alloc]init];
    _donorLabel.frame = CGRectMake(90, 60, SCREEN_WIDTH - 120, 20);
    _donorLabel.font = [UIFont systemFontOfSize:12];
    _donorLabel.textColor = HJRGBA(204, 204, 204, 1.0);
    _donorLabel.textAlignment = NSTextAlignmentLeft;
    _donorLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _donorLabel.numberOfLines = 0;
    [self addSubview:_donorLabel];
    
    _timeDateLabel = [[UILabel alloc]init];
    _timeDateLabel.frame = CGRectMake(90, 60, SCREEN_WIDTH - 120, 20);
    _timeDateLabel.font = [UIFont systemFontOfSize:12];
    _timeDateLabel.textColor = HJRGBA(204, 204, 204, 1.0);
    _timeDateLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_timeDateLabel];
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
    if (!_indexPath.section) {
        _iconImageView.image = [UIImage imageNamed:model.goodsIcon];
        _titleLabel.text = model.title;
        _donneLabel.text = model.donee;
        _donorLabel.text = model.donor;
        [_donorLabel sizeToFit];
        _donorLabel.frame = CGRectMake(90, 60, _donorLabel.frame.size.width, 20);
        _timeDateLabel.text = model.timeDate;
        //    _timeDateLabel.frame = CGRectMake(SCREEN_WIDTH * 2/3 - 30, 60, SCREEN_WIDTH/3, 20);
        CGFloat x = _donorLabel.frame.origin.x + _donorLabel.frame.size.width + 15;
        _timeDateLabel.frame = CGRectMake(x, 60, SCREEN_WIDTH/3, 20);
        
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

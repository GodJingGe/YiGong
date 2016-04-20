//
//  HJPubActivityTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPubActivityTableViewCell.h"

@implementation HJPubActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self.titleLabel.text = @"认证公益团队";
    }
    return self;
}

- (UIImageView *)iconImageView{
    
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.frame = CGRectMake(SCREEN_WIDTH - 55, 10, 40, 40);
        _iconImageView.image = [UIImage imageNamed:@"headp-80x80_01"];
        _iconImageView.layer.cornerRadius = CGRectGetWidth(_iconImageView.frame)/2;
        _iconImageView.clipsToBounds = YES;
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}


- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.frame = CGRectMake(SCREEN_WIDTH *2/3 - 30, 20, SCREEN_WIDTH /3, 20);
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = HJRGBA(170, 170, 170, 1.0);
        _detailLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(20, 20, SCREEN_WIDTH/3, 20);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (indexPath.row) {
        [self addSubview:self.detailLabel];
         self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        [self addSubview:self.iconImageView];
    }
}


@end

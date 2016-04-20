//
//  HJPersonalTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPersonalTableViewCell.h"

@implementation HJPersonalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.titleLabel.text = @"认证公益团队";
    }
    return self;
}

- (UIImageView *)iconImageView{

    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.frame = CGRectMake(SCREEN_WIDTH - 80, 10, 40, 40);
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
        _detailLabel.frame = CGRectMake(SCREEN_WIDTH /3 + 30, 20, SCREEN_WIDTH *2/3 - 60, 20);
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

- (void)setModel:(HJPersonalModel *)model{
    _model = model;
    switch (_indexPath.row) {
        case 0:
        {
            NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,model.avatar]];
            [self.iconImageView sd_setImageWithURL:url];
        }
            break;
        case 1:
            self.detailLabel.text = model.nickName;
            break;
        case 2:
            self.detailLabel.text = model.sex;
            break;
        case 3:
            self.detailLabel.text = model.birthday;
            break;
        case 4:
            self.detailLabel.text = model.phoneNum;
            break;
        case 5:
            self.detailLabel.text = model.address;
            break;
        case 6:
            self.detailLabel.text = model.career;
            break;
        case 7:
            self.detailLabel.text = model.signature;
            break;
    }
}

//- (void)setIndexPath:(NSIndexPath *)indexPath{
//    _indexPath = indexPath;
//    if (indexPath.row) {
//        [self addSubview:self.detailLabel];
//    }else{
//        [self addSubview:self.iconImageView];
//    }
//}


@end

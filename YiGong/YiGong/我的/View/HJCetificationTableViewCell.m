
//
//  HJCetificationTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/9.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJCetificationTableViewCell.h"

@implementation HJCetificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = NO;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    return self;
}

- (UIImageView *)logoImageV{
    if (!_logoImageV) {
        _logoImageV = [[UIImageView alloc]init];
        _logoImageV.frame = CGRectMake(SCREEN_WIDTH - 80, 10, 40, 40);
        _logoImageV.image = [UIImage imageNamed:@"team_img01"];
        _logoImageV.layer.cornerRadius = CGRectGetWidth(_logoImageV.frame)/2;
        _logoImageV.clipsToBounds = YES;
        _logoImageV.layer.borderWidth = 0.5;
        _logoImageV.layer.borderColor = HJRGBA(219, 219, 219, 1.0).CGColor;
    }
    return _logoImageV;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.frame = CGRectMake(SCREEN_WIDTH / 2 - 30, 20, SCREEN_WIDTH / 2 , 20);
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = HJRGBA(170, 170, 170, 1.0);
        _detailLabel.text = @"请输入信息";
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


//- (void)setModel:(HJCertificationModel *)model{
//    switch (_indexPath.row) {
//        case 0:
//            self.titleLabel.text = model
//            break;
//        case 1:
//            
//            break;
//        case 2:
//            
//            break;
//        case 3:
//            
//            break;
//        case 4:
//            
//            break;
//        case 5:
//            
//            break;
//    }
//}

@end

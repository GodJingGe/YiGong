//
//  HJMineTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJMineTableViewCell.h"

@implementation HJMineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.titleLabel.text = @"认证公益团队";
    }
    return self;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.frame = CGRectMake(15, 40, SCREEN_WIDTH - 45, 20);
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = HJRGBA(170, 170, 170, 1.0);
        _detailLabel.text = @"刚刚 参加了报名";
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(20, 20, SCREEN_WIDTH - 85, 20);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}

@end

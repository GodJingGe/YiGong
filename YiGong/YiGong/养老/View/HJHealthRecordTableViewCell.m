//
//  HJHealthRecordTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJHealthRecordTableViewCell.h"

@implementation HJHealthRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(15, 20, SCREEN_WIDTH/2, 20);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = HJRGBA(170, 170, 170, 1.0);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];
        
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.frame = CGRectMake(SCREEN_WIDTH *2/3 - 30, 20, SCREEN_WIDTH/3, 20);
        _detailLabel.font = [UIFont systemFontOfSize:16];
        _detailLabel.textColor = HJRGBA(100, 100, 100, 1.0);
        _detailLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_detailLabel];

    }
    return _detailLabel;
}

- (void)setModel:(HJHealthRecordModel *)model{
    _model = model;
    self.titleLabel.text = model.timeDate;
    self.detailLabel.text = model.value;
}
@end

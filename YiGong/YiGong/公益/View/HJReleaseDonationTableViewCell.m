//
//  HJReleaseDonationTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJReleaseDonationTableViewCell.h"

@implementation HJReleaseDonationTableViewCell

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
- (void)createUI{
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(15, 20, SCREEN_WIDTH - 85, 20);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _textF = [[UITextField alloc]init];
    _textF.frame = CGRectMake(110, 15, SCREEN_WIDTH - 150, 30);
    _textF.textAlignment = NSTextAlignmentRight;
    [self addSubview:_textF];
}

- (void)setModel:(HJReleaseModel *)model{
    _model = model;
    [self createUI];
    _titleLabel.text = model.title;
    _textF.placeholder = model.content;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

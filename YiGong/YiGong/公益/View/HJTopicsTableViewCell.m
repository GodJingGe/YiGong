//
//  HJTopicsTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTopicsTableViewCell.h"

@implementation HJTopicsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self createUI];
    }
    return self;
}
- (void)createUI{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 20);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = HJRGBA(100, 100, 100, 1.0);
    _titleLabel.text = @"沐沐沐雅";
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _donorLabel = [[UILabel alloc]init];
    _donorLabel.frame = CGRectMake(15, 45, SCREEN_WIDTH - 120, 20);
    _donorLabel.font = [UIFont systemFontOfSize:12];
    _donorLabel.textColor = HJRGBA(204, 204, 204, 1.0);
    _donorLabel.textAlignment = NSTextAlignmentLeft;
    _donorLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _donorLabel.numberOfLines = 0;
    [self addSubview:_donorLabel];
    
    _timeDateLabel = [[UILabel alloc]init];
    _timeDateLabel.frame = CGRectMake(15, 45, SCREEN_WIDTH - 120, 20);
    _timeDateLabel.font = [UIFont systemFontOfSize:12];
    _timeDateLabel.textColor = HJRGBA(204, 204, 204, 1.0);
    _timeDateLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_timeDateLabel];
}

- (void)setModel:(HJTopicModel *)model{
    
    _model = model;
    _titleLabel.text = model.title;
    _donorLabel.text = model.author;
    [_donorLabel sizeToFit];
    _donorLabel.frame = CGRectMake(15, 45, _donorLabel.frame.size.width, 20);
    _timeDateLabel.text = model.timeDate;
    //    _timeDateLabel.frame = CGRectMake(SCREEN_WIDTH * 2/3 - 30, 60, SCREEN_WIDTH/3, 20);
    CGFloat x = _donorLabel.frame.origin.x + _donorLabel.frame.size.width + 15;
    _timeDateLabel.frame = CGRectMake(x, 45, SCREEN_WIDTH/3, 20);
    
    
}

@end

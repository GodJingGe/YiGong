//
//  HJMainTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJMainTableViewCell.h"

@implementation HJMainTableViewCell

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
    _topicImageView = [[UIImageView alloc]init];
    _topicImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 226);
    _topicImageView.image = [UIImage imageNamed:@"banner"];
    [self addSubview:_topicImageView];
    
    _summaryView = [[HJMainSummaryView alloc]init];
    _summaryView.frame = CGRectMake(0, 226, SCREEN_WIDTH, 76);
    [self addSubview:_summaryView];
}

- (void)setModel:(HJMainModel *)model{
    _model = model;
    if (_model.images.count) 
    _imageModel = _model.images[0];
    NSString * url = [NSString stringWithFormat:COMMON_IMAGE_URL,_imageModel.imageUrl];
    [_topicImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:nil];
    _summaryView.model = model;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  HJGCMServiceTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJGCMServiceTableViewCell.h"

@implementation HJGCMServiceTableViewCell

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
    _topicImageView.image = [UIImage imageNamed:@"old01"];
    [self addSubview:_topicImageView];
    
    _summaryView = [[HJServiceSummary alloc]init];
    _summaryView.frame = CGRectMake(0, 226, SCREEN_WIDTH, 76);
    [self addSubview:_summaryView];
}

- (void)setModel:(HJGcmModel *)model{
    _model = model;
    _summaryView.model = model;
}


@end

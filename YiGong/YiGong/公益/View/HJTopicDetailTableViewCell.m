//
//  HJTopicDetailTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJTopicDetailTableViewCell.h"

@implementation HJTopicDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:@"YiGong"];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (HJCommentView *)commentView{
    if (!_commentView) {
        _commentView = [[HJCommentView alloc]init];
        _commentView.iconImageView.image = [UIImage imageNamed:@"headp-80x80_01"];
        _commentView.commentTextView.text = @"这个活动真心不错，正能量爆棚啊！~";
        _commentView.nickNameLabel.text = @"沐沐沐雅";
        _commentView.commentTimeLabel.text = @"刚刚 发布";
        [_commentView  resetFrame];
        [self addSubview:_commentView];
        self.frame = _commentView.bounds;
    }
    return _commentView;
}


- (void)setModel:(HJTopicModel *)model{
    model = model;
    self.commentView.iconImageView.image = [UIImage imageNamed:model.avatar];
    self.commentView.nickNameLabel.text = model.author;
    self.commentView.commentTextView.text = model.content;
    self.commentView.commentTimeLabel.text = model.timeDate;
    [self.commentView resetFrame];
    self.frame = self.commentView.frame;
}

@end

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

- (void)setTopicModel:(HJTopicModel *)topicModel{
    _topicModel = topicModel;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,topicModel.avatar]];
    [self.commentView.iconImageView sd_setImageWithURL:url];
    self.commentView.nickNameLabel.text = topicModel.author;
    self.commentView.commentTimeLabel.text = topicModel.timeDate;

}

- (void)setModel:(HJTopicCommentModel *)model{
    _model = model;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,model.avatar]];
    [self.commentView.iconImageView sd_setImageWithURL:url];
    if ([model.type isEqualToString:@"1"]) {
        self.commentView.commentTextView.text = model.messageContent;
    }else{
        self.commentView.commentTextView.attributedText = [self getAttributeString];
    }
    self.commentView.nickNameLabel.text = model.nickName;
    self.commentView.commentTimeLabel.text = model.commentTime;
    [self.commentView  resetFrame];
    self.frame = _commentView.bounds;
}
- (NSMutableAttributedString *)getAttributeString{
    NSString * commentStr = [NSString stringWithFormat:@"回复@%@：%@",_model.replyNickName,_model.messageContent];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:commentStr];
    [attrString addAttribute:NSForegroundColorAttributeName value:HJRGBA(170, 170, 170, 1.0) range:NSMakeRange(0, attrString.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:HJRGBA(158, 161, 220, 1.0) range:NSMakeRange(2, _model.replyNickName.length + 1)];
    return attrString;
}
@end

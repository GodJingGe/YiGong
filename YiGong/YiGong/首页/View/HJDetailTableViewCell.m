//
//  HJDetailTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/3/31.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJDetailTableViewCell.h"

@implementation HJDetailTableViewCell

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

// 活动信息
- (HJDetailSummaryView *)summaryView{
    if (!_summaryView) {
        _summaryView = [[HJDetailSummaryView alloc]init];
        _summaryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 76);
        [self addSubview:_summaryView];
        self.frame = _summaryView.bounds;
    }
    return _summaryView;
}

// 参加人数
- (HJPartakePersonView *)partakePersonView{
    if (!_partakePersonView) {
        _partakePersonView = [[HJPartakePersonView alloc]init];
        _partakePersonView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
        [self addSubview:_partakePersonView];
        self.frame = _partakePersonView.bounds;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return _partakePersonView;
}
// 活动介绍
- (HJActIntroduceView *)actIntrView{
    if (!_actIntrView) {
        _actIntrView = [[HJActIntroduceView alloc]init];
        _actIntrView.actTextView.text = @"由于画展展期恰逢暑假，许多小朋友也和家长共同参观。展览现场也特意准备了亲子活动区，铺设了10米长卷和蜡笔供观众们绘画涂鸦。孩子们受到展出作品的启发，也在长卷上大展身手。画展还未过半，长卷几乎已经被参观者的绘画填满，主办方不得不再加设长卷以继续活动。16日与17日，由于艺术家任倢的到来，前来参观的人数更创画展来访人数新高。慕名而来的参观者们为一度艺术家风采，提前入场等候。现场小朋友与艺术家的互动环节获得了孩子们的喜爱，她生动而别具一格的绘画指导让小朋友不仅感受到了绘画的魅力，也提高了孩子们的绘画技巧。在活动上，任倢不仅将孩子们的涂鸦锦上添花，并将长卷上所有绘画有机地组合成一个整体，让在场观众和小朋友们零距离感受了艺术家的工作氛围。";
        _actIntrView.actTextView.frame = CGRectMake(15, 0, SCREEN_WIDTH - 15, _actIntrView.actTextView.contentSize.height + 20);
        _actIntrView.frame = _actIntrView.actTextView.bounds;
        self.frame = _actIntrView.bounds;
        [self addSubview:_actIntrView];
    }
    return _actIntrView;
}

//活动内容赋值
- (void)setContent:(NSString *)content{
    self.actIntrView.content = content;
    self.frame = self.actIntrView.frame;
}

// 活动行程
- (HJActIntroduceView *)actProcessView{
    if (!_actProcessView) {
        _actProcessView = [[HJActIntroduceView alloc]init];
        _actProcessView.actTextView.text = @"08:30 文岚街89号花坛集合 \n\n09:00 坐大巴到达活动地点 \n\n09:30 开始清点人数，开始活动 \n\n12:00 主办方提供就餐";
        _actProcessView.actTextView.frame = CGRectMake(15, 0, SCREEN_WIDTH - 15, _actProcessView.actTextView.contentSize.height + 20);
        _actProcessView.frame = _actProcessView.actTextView.bounds;
        self.frame = _actProcessView.bounds;
        [self addSubview:_actProcessView];
    }
    return _actProcessView;
}
// 活动行程赋值
- (void)setSchedule:(NSString *)schedule{
    self.actProcessView.schedule = schedule;
    self.frame = self.actProcessView.frame;
}

// 活动回顾
- (HJActReviewView *)actReviewView{
    if (!_actIntrView) {
        _actReviewView = [[HJActReviewView alloc]initWithBrowserPictures:^{
            self.browserPicBlock(self.reviewImages);
        }];
        [_actReviewView.actPicBtn setBackgroundImage:[UIImage imageNamed:@"ban"] forState:UIControlStateNormal];
        [self addSubview:_actReviewView];
        _actReviewView.frame = _actReviewView.actPicBtn.bounds;
        self.frame = _actReviewView.bounds;
    }
    return _actReviewView;
}
// 活动回顾赋值
- (void)setReviewImages:(NSMutableArray *)reviewImages{
    _reviewImages = reviewImages;
    if (reviewImages.count) {
    [self.actReviewView.actPicBtn setBackgroundImage:reviewImages[0] forState:UIControlStateNormal];
    }
}

// 评论
- (HJCommentView *)commentView{
    if (!_commentView) {
        _commentView = [[HJCommentView alloc]init];
        [self addSubview:_commentView];
    }
    return _commentView;
}


// 传过来的评论模型
- (void)setCommentModel:(HJCommentModel *)commentModel{
    _commentModel = commentModel;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,commentModel.avatar]];
    [self.commentView.iconImageView sd_setImageWithURL:url];
    if ([commentModel.type isEqualToString:@"1"]) {
        self.commentView.commentTextView.text = commentModel.messageContent;
    }else{
        self.commentView.commentTextView.attributedText = [self getAttributeString];
    }
    self.commentView.nickNameLabel.text = commentModel.nickName;
    self.commentView.commentTimeLabel.text = commentModel.commentTime;
    [self.commentView  resetFrame];
    self.frame = _commentView.bounds;
}

- (NSMutableAttributedString *)getAttributeString{
    NSString * commentStr = [NSString stringWithFormat:@"回复@%@：%@",_commentModel.replyNickName,_commentModel.messageContent];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:commentStr];
    [attrString addAttribute:NSForegroundColorAttributeName value:HJRGBA(170, 170, 170, 1.0) range:NSMakeRange(0, attrString.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:HJRGBA(158, 161, 220, 1.0) range:NSMakeRange(2, _commentModel.replyNickName.length + 1)];
    return attrString;
}

// 传过来的主页模型
- (void)setMainModel:(HJMainModel *)mainModel{
    _mainModel = mainModel;
    self.summaryView.model = mainModel;
    _actReviewView.titleLabel.text = _mainModel.activityTitle;
}

// 报名视图赋值
- (void)setPartakeDatas:(NSMutableArray *)partakeDatas andModel:(HJMainModel *)model{
    
    NSMutableArray * arr = [NSMutableArray array];
    for (HJPartakeModel *model in partakeDatas) {
        [arr addObject:model.avatar];
        if (arr.count >= 5) return;
    }
    self.partakePersonView.model = model;
    self.partakePersonView.partakePersons = arr;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

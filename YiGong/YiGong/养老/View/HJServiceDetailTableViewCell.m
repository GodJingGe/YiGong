//
//  HJServiceDetailTableViewCell.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJServiceDetailTableViewCell.h"

@implementation HJServiceDetailTableViewCell

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
- (void)createUI{
    switch (_indexPath.section) {
        case 0:{
            _summaryView = [[HJServiceSummary alloc]init];
            _summaryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 76);
            [_summaryView.callBtn addTarget:self action:@selector(contactGcm:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_summaryView];
            self.frame = _summaryView.bounds;
        }
            break;
        case 1:{
            _introductionView = [[HJServiceContentView alloc]init];
            [self addSubview:_introductionView];
            
        }
            break;
        case 2:{
            _serviceView = [[HJServiceContentView alloc]init];
            [self addSubview:_serviceView];
        }
            break;
        case 3:{
            _healthCareView = [[HJServiceContentView alloc]init];
            [self addSubview:_healthCareView];
        }
        
            break;
        case 4:{
            _rctEquipmentView = [[HJServiceContentView alloc]init];
            [self addSubview:_rctEquipmentView];
        }
        
            break;
        case 5:
        {
            _commentView = [[HJCommentView alloc]init];
            [self addSubview:_commentView];
            self.frame = _commentView.bounds;
        }
            break;
    }
    
}

#pragma mark --------------ClickAction
- (void)contactGcm:(UIButton *)button{
    HJLog(@"拨打电话");
    if (self.callToGcmBlock) {
        self.callToGcmBlock(_model.phoneNum);
    }
}


- (void)setModel:(HJGcmModel *)model{
    [self createUI];
    _model = model;
    _summaryView.model = model;
    if (_introductionView) {
        _introductionView.textV.text = model.gcmSummary;
        [_introductionView resetFrame];
        self.frame = _introductionView.bounds;
    }
    
    if (_serviceView) {
        _serviceView.textV.text = model.gcmService;
        [_serviceView resetFrame];
        self.frame = _serviceView.bounds;

    }

    if (_healthCareView) {
        _healthCareView.textV.text = model.healthCare;
        [_healthCareView resetFrame];
        self.frame = _healthCareView.bounds;
    }
    
    if (_rctEquipmentView) {
        _rctEquipmentView.textV.text = model.rctEquipment;
        [_rctEquipmentView resetFrame];
        self.frame = _rctEquipmentView.bounds;
    }
    
}

// 传过来的评论模型

- (void)setCommentModel:(HJGcmCommentModel *)commentModel{
    [self createUI];
    if (_commentView) {
//        NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:COMMON_IMAGE_URL,commentModel.avatar]];
//        [_commentView.iconImageView sd_setImageWithURL:url];
//
//        _commentView.commentTextView.text = commentModel.messageContent;
//        _commentView.nickNameLabel.text = commentModel.nickName;
//        _commentView.commentTimeLabel.text = commentModel.commentTime;
//        [_commentView  resetFrame];
//        [self addSubview:_commentView];
//        self.frame = _commentView.bounds;
        
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
}
- (NSMutableAttributedString *)getAttributeString{
    NSString * commentStr = [NSString stringWithFormat:@"回复@%@：%@",_commentModel.replyNickName,_commentModel.messageContent];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:commentStr];
    [attrString addAttribute:NSForegroundColorAttributeName value:HJRGBA(170, 170, 170, 1.0) range:NSMakeRange(0, attrString.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:HJRGBA(158, 161, 220, 1.0) range:NSMakeRange(2, _commentModel.replyNickName.length + 1)];
    return attrString;
}

//- (HJServiceSummary *)summaryView{
//    if (!_summaryView) {
//        _summaryView = [[HJServiceSummary alloc]init];
//        _summaryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 76);
//        [_summaryView.callBtn addTarget:self action:@selector(contactGcm:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_summaryView];
//        self.frame = _summaryView.bounds;
//    }
//    return _summaryView;
//}
//
//- (HJServiceContentView *)introductionView{
//    if (!_introductionView) {
//        _introductionView = [[HJServiceContentView alloc]init];
//        [self addSubview:_introductionView];
//    }
//    return _introductionView;
//}
//- (HJServiceContentView *)serviceView{
//    if (!_serviceView) {
//        _serviceView = [[HJServiceContentView alloc]init];
//        [self addSubview:_serviceView];
//    }
//    return _serviceView;
//}
//- (HJServiceContentView *)healthCareView{
//    if (!_healthCareView) {
//        _healthCareView = [[HJServiceContentView alloc]init];
//        [self addSubview:_healthCareView];
//    }
//    return _healthCareView;
//}
//- (HJServiceContentView *)rctEquipmentView{
//    if (!_rctEquipmentView) {
//        _rctEquipmentView = [[HJServiceContentView alloc]init];
//    }
//    return _rctEquipmentView;
//}
//- (HJCommentView *)commentView{
//    if (!_commentView) {
//        _commentView = [[HJCommentView alloc]init];
//        _commentView.iconImageView.image = [UIImage imageNamed:@"headp-80x80_01"];
//        _commentView.commentTextView.text = @"这个活动真心不错，正能量爆棚啊！~";
//        _commentView.nickNameLabel.text = @"沐沐沐雅";
//        _commentView.commentTimeLabel.text = @"刚刚 发布";
//        [_commentView  resetFrame];
//        [self addSubview:_commentView];
//        self.frame = _commentView.bounds;
//    }
//    return _commentView;
//}
//
//
//#pragma mark --------------ClickAction
//- (void)contactGcm:(UIButton *)button{
//    HJLog(@"拨打电话");
//    if (self.callToGcmBlock) {
//        self.callToGcmBlock(_model.phoneNum);
//    }
//}
//
//
//- (void)setModel:(HJGcmModel *)model{
//    _model = model;
//    switch (_indexPath.section) {
//        case 0:{
//            self.summaryView.model = model;
//            
//        }
//            break;
//        case 1:{
//            
//            self.introductionView.textV.text = model.gcmSummary;
//            [self.introductionView resetFrame];
//            self.frame = _introductionView.bounds;
//            
//        }
//            break;
//        case 2:{
//            
//            self.serviceView.textV.text = model.gcmService;
//            [self.serviceView resetFrame];
//            self.frame = self.serviceView.bounds;
//        }
//            break;
//        case 3:{
//            
//            self.healthCareView.textV.text = model.healthCare;
//            [self.healthCareView resetFrame];
//            self.frame = self.healthCareView.bounds;
//        }
//            
//            break;
//        case 4:{
//            
//            self.rctEquipmentView.textV.text = model.rctEquipment;
//            [self.rctEquipmentView resetFrame];
//            self.frame = self.rctEquipmentView.bounds;
//        }
//            
//            break;
//        case 5:
//            break;
//    }
//    
//    
//}
//
//
//- (void)setCommentModel:(HJGcmCommentModel *)commentModel{
//    _commentModel = commentModel;
//    if (_indexPath.section == 5) {
//        _commentView = [[HJCommentView alloc]init];
//        _commentView.iconImageView.image = [UIImage imageNamed:@"headp-80x80_01"];
//        _commentView.commentTextView.text = @"这个活动真心不错，正能量爆棚啊！~";
//        _commentView.nickNameLabel.text = @"沐沐沐雅";
//        _commentView.commentTimeLabel.text = @"刚刚 发布";
//        [_commentView  resetFrame];
//        [self addSubview:_commentView];
//        self.frame = _commentView.bounds;
//    }
//}

@end

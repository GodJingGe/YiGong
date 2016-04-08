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
            _commentView.iconImageView.image = [UIImage imageNamed:@"headp-80x80_01"];
            _commentView.commentTextView.text = @"这个活动真心不错，正能量爆棚啊！~";
            _commentView.nickNameLabel.text = @"沐沐沐雅";
            _commentView.commentTimeLabel.text = @"刚刚 发布";
            [_commentView  resetFrame];
            [self addSubview:_commentView];
            self.frame = _commentView.bounds;
        }
            break;
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
        _healthCareView.textV.text = model.rctEquipment;
        [_healthCareView resetFrame];
        self.frame = _healthCareView.bounds;
    }
    
    if (_rctEquipmentView) {
        _rctEquipmentView.textV.text = model.healthCare;
        [_rctEquipmentView resetFrame];
        self.frame = _rctEquipmentView.bounds;
    }
    
    if (_commentView) {
        
    }
}

@end

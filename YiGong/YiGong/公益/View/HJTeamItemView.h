//
//  HJTeamItemView.h
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJTeamItemView : UIView
/** 标题*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 详情*/
@property(nonatomic, strong) UILabel *detailLabel;
/** 点击事件*/
@property(nonatomic, strong) UIButton *clickBtn;
@end

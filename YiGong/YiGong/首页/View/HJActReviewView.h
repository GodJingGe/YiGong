//
//  HJActReviewView.h
//  YiGong
//
//  Created by 黄靖 on 16/4/1.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJActReviewView : UIView
/** 活动图片*/
@property(nonatomic, strong) NSMutableArray *picData;
/** 图片*/
@property(nonatomic, strong) UIButton *actPicBtn;
/** 标题遮罩*/
@property(nonatomic, strong) UIView *titleView;
/** 标题*/
@property(nonatomic, strong) UILabel *titleLabel;
@end

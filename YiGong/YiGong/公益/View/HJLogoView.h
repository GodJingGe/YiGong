//
//  HJLogoView.h
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJLogoView : UIView
/** logo遮罩*/
@property(nonatomic, strong) UIView *logoBgView;
/** 团队logo*/
@property(nonatomic, strong) UIImageView *teamIconImageV;
/** 关注图片*/
@property(nonatomic, strong) UIImageView *followImageV;
@end

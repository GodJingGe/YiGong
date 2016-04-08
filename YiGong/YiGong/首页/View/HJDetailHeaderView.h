//
//  HJDetailHeaderView.h
//  YiGong
//
//  Created by 黄靖 on 16/3/31.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJDetailHeaderView : UIView
/** titleLabel*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 时间*/
@property(nonatomic, strong) UILabel *timeDateLabel;
/** 添加图片*/
@property(nonatomic, strong) UIButton *addPicBtn;
/** 跳转视图*/
@property(nonatomic, copy)void(^pushToPickerViewBlock)(void);
@end

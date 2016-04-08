//
//  HJPublishView.h
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJPublishView : UIView
/** intputTextView*/
@property(nonatomic, strong) UITextView *textV;
/** placeholderLabel*/
@property(nonatomic, strong) UILabel *placeholerLabel;
/** lengthLabel*/
@property(nonatomic, strong) UILabel *lengthLabel;
/** 文本框背景*/
@property(nonatomic, strong) UIView *textBgView;
/** 标题文本框*/
@property(nonatomic, strong) UITextField *titleTF;
@end

//
//  HJFooterView.h
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJFooterView : UIView
/** block*/
@property (nonatomic, copy) void (^clickBlock)(void);
/** UIButton*/
@property(nonatomic, strong) UIButton *footerBtn;

- (instancetype)initWithAction:(void(^)(void))handler;
@end

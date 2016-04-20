//
//  HJMyLabel.h
//  AINursing
//
//  Created by 黄靖 on 16/3/14.
//  Copyright © 2016年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJMyLabel : UILabel

@property(nonatomic) UIEdgeInsets insets;

-(id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;
-(id) initWithInsets: (UIEdgeInsets) insets;

@end

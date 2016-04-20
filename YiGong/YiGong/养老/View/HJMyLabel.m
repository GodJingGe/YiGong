//
//  HJMyLabel.m
//  AINursing
//
//  Created by 黄靖 on 16/3/14.
//  Copyright © 2016年 黄靖. All rights reserved.
//

#import "HJMyLabel.h"

@implementation HJMyLabel

-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(id) initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(void) drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}


@end

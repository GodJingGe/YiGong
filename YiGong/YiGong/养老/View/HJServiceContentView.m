//
//  HJServiceContentView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJServiceContentView.h"

@implementation HJServiceContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textV = [[UITextView alloc]init];
        self.textV.frame = CGRectMake(15, 0, SCREEN_WIDTH - 15, 30);
        self.textV.textColor = HJRGBA(170, 170, 170, 1.0);
        self.textV.font = [UIFont systemFontOfSize:14];
        self.textV.editable = NO;
        [self addSubview:self.textV];
        
    }
    return self;
}
- (void)resetFrame{
    
    self.textV.frame = CGRectMake(15, 0, SCREEN_WIDTH-15, self.textV.contentSize.height + 10);
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.textV.frame.size.height);
    
}
@end

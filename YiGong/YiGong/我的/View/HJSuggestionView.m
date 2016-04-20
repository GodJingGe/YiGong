//
//  HJSuggestionView.m
//  AINursing
//
//  Created by 黄靖 on 16/3/9.
//  Copyright © 2016年 黄靖. All rights reserved.
//

#import "HJSuggestionView.h"

@implementation HJSuggestionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.frame = CGRectMake(0, 64, SCREEN_WIDTH, 150);
    _textV = [[UITextView alloc]init];
    _textV.frame = self.bounds;
    _textV.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textV];
    
    _placeholerLabel = [[UILabel alloc]init];
    _placeholerLabel.frame = CGRectMake(10, 5, SCREEN_WIDTH, 22);
    _placeholerLabel.text = @"请在此输入信息";
    _placeholerLabel.textColor = HJRGBA(204, 204, 204, 1.0);
    _placeholerLabel.font = [UIFont systemFontOfSize:14];
    [_textV addSubview:_placeholerLabel];
    
    _lengthLabel = [[UILabel alloc]init];
    _lengthLabel.frame = CGRectMake(SCREEN_WIDTH - 40, self.frame.size.height - 20  , 40, 22);
    _lengthLabel.textAlignment = NSTextAlignmentCenter;
    _lengthLabel.text = @"140";
    _lengthLabel.textColor = HJRGBA(204, 204, 204, 1.0);
    _lengthLabel.font = [UIFont systemFontOfSize:14];
    [_textV addSubview:_lengthLabel];
}
@end

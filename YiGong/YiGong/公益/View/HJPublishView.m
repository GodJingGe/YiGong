//
//  HJPublishView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJPublishView.h"

@implementation HJPublishView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    _textV = [[UITextView alloc]init];
    _textV.frame = self.bounds;
    _textV.font = [UIFont systemFontOfSize:14];
    [self addSubview:_textV];
    
    _placeholerLabel = [[UILabel alloc]init];
    _placeholerLabel.frame = CGRectMake(10, 5, SCREEN_WIDTH, 22);
    _placeholerLabel.text = @"请在此输入信息";
    _placeholerLabel.textColor = HJRGBA(204, 204, 204, 1.0);
    _placeholerLabel.font = [UIFont systemFontOfSize:17];
    [_textV addSubview:_placeholerLabel];
    
    _lengthLabel = [[UILabel alloc]init];
    _lengthLabel.frame = CGRectMake(SCREEN_WIDTH - 40, self.frame.size.height - 20  , 40, 22);
    _lengthLabel.textAlignment = NSTextAlignmentCenter;
    _lengthLabel.text = @"140";
    _lengthLabel.textColor = HJRGBA(204, 204, 204, 1.0);
    _lengthLabel.font = [UIFont systemFontOfSize:14];
    [_textV addSubview:_lengthLabel];
    
}
- (UIView *)textBgView{
    if (!_textBgView) {
        _textBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _textBgView.backgroundColor = [UIColor whiteColor];
        [self resetFrame];
        
        [_textBgView addSubview:self.titleTF];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _textBgView.frame.size.height - 0.5, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = HJRGBA(229, 229, 229, 1.0);
        [_textBgView addSubview:lineView];
    }
    return _textBgView;
}

- (UITextField *)titleTF{
    if (!_titleTF) {
        _titleTF = [[UITextField alloc]init];
        _titleTF.frame = CGRectMake(10 , 15, SCREEN_WIDTH - 25, 30);
        [_titleTF setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    }
    return _titleTF;
}

- (void)resetFrame{
    _textV.frame = CGRectMake(0, _textBgView.frame.size.height, SCREEN_WIDTH, 150);
    CGFloat height = _textV.frame.size.height + _textV.frame.origin.y;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
}
@end

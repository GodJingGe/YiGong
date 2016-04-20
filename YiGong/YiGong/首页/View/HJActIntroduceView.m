//
//  HJActIntroduceView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/1.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJActIntroduceView.h"

@implementation HJActIntroduceView
- (UITextView *)actTextView{
    if (!_actTextView) {
        _actTextView = [[UITextView alloc]init];
        _actTextView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 10, 100);
        _actTextView.textColor = HJRGBA(170, 170, 170, 1.0);
        _actTextView.font = [UIFont systemFontOfSize:14];
//        _actTextView.scrollEnabled = NO;
//        [self.actTextView setContentInset:UIEdgeInsetsMake(0, 15, 0, 0)];
        _actTextView.editable = NO;
        [self addSubview:_actTextView];
    }
    return _actTextView;
}

- (void)setContent:(NSString *)content{
    _content = content;
    self.actTextView.text = content;
    self.actTextView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 10, self.actTextView.contentSize.height + 10);
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.actTextView.frame));
}
// 活动行程
- (void)setSchedule:(NSString *)schedule{
    _schedule = schedule;
    self.actTextView.text = schedule;
    self.actTextView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 10, self.actTextView.contentSize.height + 10);
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.actTextView.frame));
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end

//
//  HJDatePickerView.m
//  AINursing
//
//  Created by 黄靖 on 16/2/25.
//  Copyright © 2016年 黄靖. All rights reserved.
//

#import "HJDatePickerView.h"

@implementation HJDatePickerView

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/3*2-70, SCREEN_WIDTH-20, SCREEN_HEIGHT/3)];
        _datePicker.alpha = 1;
        _datePicker.clipsToBounds = YES;
        _datePicker.layer.cornerRadius = 5;
        _datePicker.backgroundColor = [UIColor whiteColor];
        //        _datePicker.maximumDate = [NSDate date];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    return _datePicker;
}

- (UIButton *)okButton{
    if (!_okButton) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.frame = CGRectMake(10, SCREEN_HEIGHT-60, SCREEN_WIDTH-20, 50);
        [_okButton setTitle:@"好的" forState:UIControlStateNormal];
        [_okButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _okButton.backgroundColor = [UIColor whiteColor];
        _okButton.layer.cornerRadius = 5;
        _okButton.alpha = 1;
        _okButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_okButton addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}

- (UITapGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelSetting:)];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
    }
    return _tap;
}

- (void)createUI{
    // 添加手势
    [self addGestureRecognizer:self.tap];
    
    // 日期选择器
    
    [self addSubview:self.datePicker];
    
    // 弹出窗口确定按钮
    
    [self addSubview:self.okButton];
    
    // 背景视图
    self.frame = CGRectMake(0, SCREEN_HEIGHT/3 + 70, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    // 当前窗口
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
    
    // 开启动画
    [self appearAnimation];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self createUI];

    }
    return self;
}




- (instancetype)initAndGetTime:(void (^)(NSString *timeDate))getTime{
    self = [super init];
    if (self) {
        
        [self createUI];
        //回调block
        _getTimeBlock = getTime;
        
    }
    return self;
}

// 确定选中
- (void)okAction:(UIButton *)button{
    
    NSDateFormatter * dfm = [[NSDateFormatter alloc]init];
    [dfm setDateFormat:@"yyyy-MM-dd hh:mm"];
   
    NSString * actionTime = [dfm stringFromDate:_datePicker.date];
    // 实现block
    if (self.getTimeBlock)
        self.getTimeBlock(actionTime);
    else{
        // 实现代理
        if (self.delegate && [self.delegate respondsToSelector:@selector(getDate:andDateString:)]) {
            [self.delegate getDate:_datePicker.date andDateString:actionTime];
        }else{
            HJLog(@"您没有设置代理或者实现代理方法");
        }
    }
    
    [self disAppearAnimation];
    
}

- (void)cancelSetting:(UIGestureRecognizer *)tap{

    [self disAppearAnimation];
}

- (void)appearAnimation{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDidStopSelector:@selector(animationComplete)];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:0];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
}

- (void)disAppearAnimation{
    
    self.backgroundColor = [UIColor clearColor];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDidStopSelector:@selector(animationComplete)];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:0];
    self.frame = CGRectMake(0, SCREEN_HEIGHT/3 + 70, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
}

- (void)animationComplete{
    if (!_isAppear) {
        self.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.1 brightness:0.1 alpha:0.5];
        _isAppear = YES;
    }else{
        _isAppear = NO;
        [self removeFromSuperview];
    }
}
@end

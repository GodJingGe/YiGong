//
//  HJDatePickerView.h
//  AINursing
//
//  Created by 黄靖 on 16/2/25.
//  Copyright © 2016年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void (^GetTimeBlock)(NSString * time);

@protocol HJDatePikerDelegate <NSObject>

- (void)getDate:(NSDate *)pikerDate andDateString:(NSString *)dateString;

@end


@interface HJDatePickerView : UIView

/** 选择器控件*/
@property(nonatomic,strong)UIDatePicker *datePicker;
/** 确定按钮*/
@property(nonatomic,strong)UIButton *okButton;
/** 获取时间*/
@property(nonatomic,copy)void (^getTimeBlock)(NSString * time);
/** 代理*/
@property(nonatomic, assign) id<HJDatePikerDelegate> delegate;
/** 手势*/
@property(nonatomic, strong) UITapGestureRecognizer *tap;
/** 是否出现*/
@property(nonatomic, assign) BOOL isAppear;

// 获取时间的初始化方法
- (instancetype)initAndGetTime:(void (^)(NSString *timeDate))getTime;
@end

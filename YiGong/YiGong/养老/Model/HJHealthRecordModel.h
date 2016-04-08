//
//  HJHealthRecordModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJHealthRecordModel : UIView
/** 类型*/
@property (nonatomic, copy) NSString *type;
/** 值*/
@property (nonatomic, copy) NSString *value;
/** 日期*/
@property (nonatomic, copy) NSString *timeDate;

@end

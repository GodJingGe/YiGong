//
//  HJTeamCertificationViewController.h
//  YiGong
//
//  Created by 黄靖 on 16/4/9.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRootViewController.h"
#import "HJCertificationModel.h"
#import "HJDatePickerView.h"

@interface HJTeamCertificationViewController : HJRootViewController
/** 模型*/
@property(nonatomic, strong) HJCertificationModel *model;
/** 日期选择器*/
@property(nonatomic, strong) HJDatePickerView *datePickerView;
@end

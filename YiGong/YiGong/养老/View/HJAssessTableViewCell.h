//
//  HJAssessTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJAssessModel.h"
@interface HJAssessTableViewCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>
/** 问题提示*/
@property(nonatomic,strong)UITextView *contentTextView;
/** 输入成绩*/
@property (nonatomic, strong)UITextField * scoreTF;
/** 评估*/
@property(nonatomic, strong) HJAssessModel *model;
/** 隐藏键盘*/
@property (nonatomic, copy) void(^hiddenKeyBoardBlock)(HJAssessTableViewCell *);
@end

//
//  HJScheduleTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/19.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJScheduleModel.h"
@interface HJScheduleTableViewCell : UITableViewCell<UITextFieldDelegate>
/** dateBtn*/
@property(nonatomic, strong) UIButton *dateBtn;
/** 内容*/
@property(nonatomic, strong) UITextField *textF;
/** 索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 模型*/
@property(nonatomic, strong) HJScheduleModel *model;

/** pickeDate*/
@property (nonatomic, copy) void (^pickerDateBlock)(void);
/** 传出当前的Cell*/
@property (nonatomic, copy) void (^getCurrentCell)(HJScheduleTableViewCell *);
@end

//
//  HJAssessTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJAssessTableViewCell : UITableViewCell<UITextFieldDelegate>

/** title*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 减*/
@property(nonatomic, strong) UIButton *reduceBtn;
/** 显示*/
@property(nonatomic, strong) UITextField *textF;
/** 加*/
@property(nonatomic, strong) UIButton *addBtn;
/** 隐藏键盘*/
@property (nonatomic, copy) void(^completeEditingBlock)(HJAssessTableViewCell *);
@end

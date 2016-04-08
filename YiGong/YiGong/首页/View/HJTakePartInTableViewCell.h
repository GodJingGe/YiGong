//
//  HJTakePartInTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJTakePartInModel.h"
@interface HJTakePartInTableViewCell : UITableViewCell<UITextFieldDelegate>
/** 索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 标题*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 详情*/
@property(nonatomic, strong) UILabel *detailLabel;
/** 手机号*/
@property(nonatomic, strong) UITextField *phoneNumTF;
/** 获取验证*/
@property(nonatomic, strong) UIButton *getCodeBtn;
/** 模型*/
@property(nonatomic, strong) HJTakePartInModel *model;
@end

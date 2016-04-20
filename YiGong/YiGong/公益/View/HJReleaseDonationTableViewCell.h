//
//  HJReleaseDonationTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJReleaseModel.h"

@interface HJReleaseDonationTableViewCell : UITableViewCell<UITextFieldDelegate>
/** 获取当前cell*/
@property (nonatomic, copy) void (^getCurrentBlock)(void);
/** 索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 标题*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 详情*/
@property(nonatomic, strong) UITextField *textF;
/** 模型*/
@property(nonatomic, strong) HJReleaseModel *model;
@end

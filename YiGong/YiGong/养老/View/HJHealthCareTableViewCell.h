//
//  HJHealthCareTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJHealthCareTableViewCell : UITableViewCell<UITextFieldDelegate>
/** 索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** title*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 添加新纪录*/
@property(nonatomic, strong) UITextField *textF;

/** 获取当前cell*/
@property (nonatomic, copy) void (^getCurrentCellBlock)(HJHealthCareTableViewCell *);
/** 更新记录*/
@property (nonatomic, copy) void (^getCurrentValueBlock)(HJHealthCareTableViewCell *);
@end

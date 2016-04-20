//
//  HJPersonalTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/12.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJPersonalModel.h"

@interface HJPersonalTableViewCell : UITableViewCell
/** 索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 标题*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 内容*/
@property(nonatomic, strong) UILabel *detailLabel;
/** 头像*/
@property(nonatomic, strong) UIImageView *iconImageView;
/** 模型*/
@property(nonatomic, strong) HJPersonalModel *model;

@end

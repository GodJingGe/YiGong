//
//  HJTeamTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJTeamModel.h"
@interface HJTeamTableViewCell : UITableViewCell
/** 索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 模型*/
@property(nonatomic, strong) HJTeamModel *model;
/** logo*/
@property(nonatomic, strong) UIImageView *iconImageView;
/** 标题*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 详情*/
@property(nonatomic, strong) UILabel *detailLabel;
@end

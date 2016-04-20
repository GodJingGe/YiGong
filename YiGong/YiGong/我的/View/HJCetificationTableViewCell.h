//
//  HJCetificationTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/9.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJCertificationModel.h"
@interface HJCetificationTableViewCell : UITableViewCell
/** 索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 标题*/
@property(nonatomic, strong) UILabel *titleLabel;
/** logo*/
@property(nonatomic, strong) UIImageView *logoImageV;
/** 详细信息*/
@property(nonatomic, strong) UILabel *detailLabel;
/** 模型*/
@property(nonatomic, strong) HJCertificationModel *model;
@end

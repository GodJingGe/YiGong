//
//  HJTopicsTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/6.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJTopicModel.h"
@interface HJTopicsTableViewCell : UITableViewCell
/** 索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 模型*/
@property(nonatomic, strong) HJTopicModel *model;
/** 标题*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 详情*/
@property(nonatomic, strong) UILabel *detailLabel;
/** 捐赠人*/
@property(nonatomic, strong) UILabel *donorLabel;
/** 发布时间*/
@property(nonatomic, strong) UILabel *timeDateLabel;

@end

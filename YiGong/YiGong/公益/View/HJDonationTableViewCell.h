//
//  HJDonationTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/5.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJDonationModel.h"
@interface HJDonationTableViewCell : UITableViewCell
/** 是否是头像*/
@property (nonatomic, assign) BOOL isAvatar;
/** 索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 模型*/
@property(nonatomic, strong) HJDonationModel *model;
/** 捐赠物品图*/
@property(nonatomic, strong) UIImageView *iconImageView;
/** 捐赠标题*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 捐赠对象*/
@property(nonatomic, strong) UILabel *donneLabel;
/** 捐赠人*/
@property(nonatomic, strong) UILabel *donorLabel;
/** 发布时间*/
@property(nonatomic, strong) UILabel *timeDateLabel;
/** 详细内容*/
@property(nonatomic, strong) UITextView *detailTextView;
@end

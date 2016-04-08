//
//  HJPartakeTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/1.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJPartakeTableViewCell : UITableViewCell
/** 头像*/
@property(nonatomic, strong) UIImageView *iconImageView;
/** 标题*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 详情*/
@property(nonatomic, strong) UILabel *detailLabel;
@end

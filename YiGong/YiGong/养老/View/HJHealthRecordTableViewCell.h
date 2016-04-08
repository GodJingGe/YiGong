//
//  HJHealthRecordTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJHealthRecordModel.h"

@interface HJHealthRecordTableViewCell : UITableViewCell
/** title*/
@property(nonatomic, strong) UILabel *titleLabel;
/** 内容*/
@property(nonatomic, strong) UILabel *detailLabel;
/** 模型*/
@property(nonatomic, strong) HJHealthRecordModel *model;
@end

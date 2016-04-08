//
//  HJServiceDetailTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGcmModel.h"
#import "HJServiceSummary.h"
#import "HJServiceContentView.h"
#import "HJCommentView.h"
@interface HJServiceDetailTableViewCell : UITableViewCell
/** 活动摘要视图*/
@property(nonatomic, strong) HJServiceSummary *summaryView;
/** 模型*/
@property(nonatomic, strong) HJGcmModel *model;
/** 当前索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 机构简介*/
@property(nonatomic, strong) HJServiceContentView *introductionView;
/** 服务收费*/
@property(nonatomic, strong) HJServiceContentView *serviceView;
/** 医疗服务*/
@property(nonatomic, strong) HJServiceContentView *healthCareView;
/** 康娱设施*/
@property(nonatomic, strong) HJServiceContentView *rctEquipmentView;
/** 评论*/
@property(nonatomic, strong) HJCommentView *commentView;
@end

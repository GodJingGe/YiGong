//
//  HJDetailTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/3/31.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJMainModel.h"
#import "HJDetailSummaryView.h"
#import "HJPartakePersonView.h"
#import "HJActIntroduceView.h"
#import "HJActReviewView.h"
#import "HJCommentView.h"
@interface HJDetailTableViewCell : UITableViewCell
/** 活动摘要视图*/
@property(nonatomic, strong) HJDetailSummaryView *summaryView;
/** 活动人数视图*/
@property(nonatomic, strong) HJPartakePersonView *partakePersonView;
/** 模型*/
@property(nonatomic, strong)  HJMainModel *model;
/** 当前索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 活动介绍页*/
@property(nonatomic, strong) HJActIntroduceView *actIntrView;
/** 活动行程页*/
@property(nonatomic, strong) HJActIntroduceView *actProcessView;
/** 活动回顾页*/
@property(nonatomic, strong) HJActReviewView *actReviewView;
/** 评论*/
@property(nonatomic, strong) HJCommentView *commentView;
@end

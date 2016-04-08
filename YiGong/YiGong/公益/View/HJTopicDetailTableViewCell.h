//
//  HJTopicDetailTableViewCell.h
//  YiGong
//
//  Created by 黄靖 on 16/4/7.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJCommentView.h"
#import "HJTopicModel.h"
@interface HJTopicDetailTableViewCell : UITableViewCell
/** 模型*/
@property(nonatomic, strong)  HJTopicModel *model;
/** 当前索引*/
@property(nonatomic, strong) NSIndexPath *indexPath;
/** 评论*/
@property(nonatomic, strong) HJCommentView *commentView;

@end

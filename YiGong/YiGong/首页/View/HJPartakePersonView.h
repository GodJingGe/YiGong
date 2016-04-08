//
//  HJPartakePersonView.h
//  YiGong
//
//  Created by 黄靖 on 16/3/31.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJMainModel.h"
@interface HJPartakePersonView : UIView
/** 模型*/
@property(nonatomic, strong) HJMainModel *model;
/** 目前参与人*/
@property(nonatomic, strong) NSMutableArray *partakePersons;
/** 参与人数*/
@property(nonatomic, strong) UILabel *personsLabel;
@end

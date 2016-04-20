//
//  HJAssessModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/19.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJAssessModel : NSObject
/** 问题编号*/
@property (nonatomic, copy) NSString *questionId;
/** 问题内容*/
@property (nonatomic, copy) NSString *content;
/** 最高成绩*/
@property (nonatomic, copy) NSString *score;
/** 获得成绩*/
@property (nonatomic, assign) NSNumber * currentScore;

@end

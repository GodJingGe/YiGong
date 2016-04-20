//
//  HJCertificationModel.h
//  YiGong
//
//  Created by 黄靖 on 16/4/9.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJCertificationModel : NSObject
/** logo*/
@property (nonatomic, copy) UIImage *logoImage;
/** teamName*/
@property (nonatomic, copy) NSString *teamName;
/** setupTime*/
@property (nonatomic, copy) NSString *setUpTime;
/** address*/
@property (nonatomic, copy) NSString *address;
/** description*/
@property (nonatomic, copy) NSString *teamDesc;
/** 证件照*/
@property(nonatomic, strong) NSMutableArray *images;
@end

//
//  HJPickerImageViewController.h
//  HJPhotoPikerDemo
//
//  Created by 黄靖 on 16/3/26.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJRootViewController.h"
@interface HJPickerImageViewController : HJRootViewController
/** title*/
@property(nonatomic, copy) NSString *imageTitle;
/** 活动id*/
@property(nonatomic, copy) NSString *activityId;
/** 是否是审核*/
@property(nonatomic, assign) BOOL isTeamCer;
/** 传回选中的图片*/
@property (nonatomic, copy) void (^getImagesBlock)(NSMutableArray *);
@end

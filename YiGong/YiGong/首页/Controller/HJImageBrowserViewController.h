//
//  HJImageBrowserViewController.h
//  YiGong
//
//  Created by 黄靖 on 16/4/15.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRootViewController.h"

@interface HJImageBrowserViewController : HJRootViewController
/** 图片*/
@property(nonatomic,strong)NSMutableArray *images;
/** 当前位置*/
@property(nonatomic,assign)int currentOffset;
@end

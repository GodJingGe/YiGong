//
//  HJChartView.h
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJChartView : UIView
/** 传过来的数据列表中的数据源*/
@property(nonatomic,strong)NSMutableArray *dataSource;
/**
 *  接受穿过来的类型
 */
@property(nonatomic,copy)NSString * type;
/**
 *  画出线
 */
-(void)showLine;
@end

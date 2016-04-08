//
//  HJAreaPickerView.h
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJAreaPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
/**  地区选择器*/
@property(nonatomic, strong) UIPickerView *pickerView;
/** 数据源*/
@property(nonatomic, strong) NSMutableArray *dataSource;
/** 省数据源*/
@property(nonatomic, strong) NSMutableArray *provinceDataSource;
/** 市数据源*/
@property(nonatomic, strong) NSMutableArray *cityDataSource;
/** 解析后的字典*/
@property(nonatomic, strong) NSMutableDictionary *dicDataSource;
/** 回调*/
@property(nonatomic,copy)void (^changeAreaBlock)(NSString *area);
@end

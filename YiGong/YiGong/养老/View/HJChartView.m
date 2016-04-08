//
//  HJChartView.m
//  YiGong
//
//  Created by 黄靖 on 16/4/8.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJChartView.h"
#import "HJHealthRecordModel.h"
#define TYPELABELH 30

@interface HJChartView()
/** 存储第一个划线的点*/
@property (nonatomic, strong) NSMutableArray *lineValue1;
/** 存储第二个划线的点*/
@property (nonatomic, strong) NSMutableArray *lineValue2;
/** 全部要花出来的数据  */
@property (nonatomic, strong) NSMutableArray *allLineData;
/** 种类label*/
@property(nonatomic, weak) UILabel *typeLable;
/** 全部种类*/
@property(nonatomic,strong) NSArray *typeArray;
@property (nonatomic) PNLineChart * lineChart;
@end

@implementation HJChartView

#pragma mark -懒加载
-(NSMutableArray *)lineValue1{
    if (!_lineValue1) {
        _lineValue1 = [NSMutableArray array];
    }
    return _lineValue1;
}
-(NSMutableArray *)lineValue2{
    if (!_lineValue2) {
        _lineValue2 = [NSMutableArray array];
    }
    return _lineValue2;
}
-(NSMutableArray *)allLineData{
    if (!_allLineData) {
        _allLineData = [NSMutableArray array];
    }
    return _allLineData;
}
-(NSArray *)typeArray{
    if (!_typeArray) {
        _typeArray = @[@"体温记录",@"脉搏记录",@"呼吸记录",@"血压记录",@"血氧记录",@"血糖记录"];
    }
    return _typeArray;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
    

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //    CGRect rect = self.bounds;
    //    rect.size.height = 200;
    //    self.lineChart.frame = rect;
    //typelabel
    self.typeLable.frame = CGRectMake(15, CGRectGetMaxY(self.lineChart.frame), Mainsize.width, TYPELABELH);
    
}

// 为当前数据进行赋值
-(void)setType:(NSInteger)type{
    _type = type;
}
/**
 *  赋值数据的时候提取出划线点
 */
-(void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    for (HJHealthRecordModel *model in dataSource) {
        NSArray *array = [model.value componentsSeparatedByString:@";"];
        [self.lineValue1 addObject:[array firstObject]];
        if (array.count>1) {
            [self.lineValue2 addObject:array[1]];
        }
    }
}

/**
 *  画出线
 */

-(void)showLine{
    {
        CGRect rect = self.bounds;
        
        self.lineChart = [[PNLineChart alloc] initWithFrame:rect];
        self.lineChart.yLabelFormat = @"%1.1f";
        self.lineChart.xLabelColor = [UIColor whiteColor];
        self.lineChart.yLabelColor = [UIColor whiteColor];
        self.lineChart.axisColor = [UIColor whiteColor];
        self.lineChart.backgroundColor = [UIColor clearColor];
        [self.lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
        self.lineChart.showCoordinateAxis = YES;
        
        //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
        //Only if you needed
        self.lineChart.yFixedValueMax = 300.0;
        self.lineChart.yFixedValueMin = 0.0;
        
        [self.lineChart setYLabels:@[
                                     @"0 ",
                                     @"50 ",
                                     @"100 ",
                                     @"150 ",
                                     @"200 "
                                    ]
         ];
        
        // Line Chart #1
        NSArray * data01Array = self.lineValue1;
        PNLineChartData *data01 = [PNLineChartData new];
        data01.dataTitle = @"Alpha";
        data01.lineWidth = 1;
        data01.color = PNWhite;
        data01.itemCount = data01Array.count;
        data01.inflexionPointStyle = PNLineChartPointStyleTriangle;
        data01.getData = ^(NSUInteger index) {
            CGFloat yValue = [data01Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        // Line Chart #2
        NSArray * data02Array = self.lineValue2;
        PNLineChartData *data02 = [PNLineChartData new];
        data02.dataTitle = @"Beta";
        data02.color = PNWhite;
        data02.lineWidth = 1;
        data02.itemCount = data02Array.count;
        data02.inflexionPointStyle = PNLineChartPointStyleCircle;
        data02.getData = ^(NSUInteger index) {
            CGFloat yValue = [data02Array[index] floatValue];
            return [PNLineChartDataItem dataItemWithY:yValue];
        };
        
        self.lineChart.chartData = @[data01, data02];
        [self.lineChart strokeChart];
        //        self.lineChart.delegate = self;
        
        
        [self addSubview:self.lineChart];
        
        self.lineChart.legendStyle = PNLegendItemStyleStacked;
        self.lineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
        self.lineChart.legendFontColor = [UIColor redColor];
        
        UIView *legend = [self.lineChart getLegendWithMaxWidth:320];
        [legend setFrame:CGRectMake(30, 340, legend.frame.size.width, legend.frame.size.width)];
        [self addSubview:legend];
    }
}
- (void)userClickedOnLineKeyPoint:(CGPoint)point lineIndex:(NSInteger)lineIndex pointIndex:(NSInteger)pointIndex{
    NSLog(@"Click Key on line %f, %f line index is %d and point index is %d",point.x, point.y,(int)lineIndex, (int)pointIndex);
}

- (void)userClickedOnLinePoint:(CGPoint)point lineIndex:(NSInteger)lineIndex{
    NSLog(@"Click on line %f, %f, line index is %d",point.x, point.y, (int)lineIndex);
}

@end

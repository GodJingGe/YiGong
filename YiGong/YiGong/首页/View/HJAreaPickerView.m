//
//  HJAreaPickerView.m
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJAreaPickerView.h"

@implementation HJAreaPickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createValue];
        [self createUI];
    }
    return self;
}
- (void)createValue{
    _dataSource = [[NSMutableArray alloc]init];
    _provinceDataSource = [[NSMutableArray alloc]init];
    _cityDataSource = [[NSMutableArray alloc]init];
    _dicDataSource = [[NSMutableDictionary alloc]init];
}

- (void)createUI{
    self.frame = CGRectMake(0, SCREEN_HEIGHT/3 + 70, SCREEN_WIDTH, SCREEN_HEIGHT);
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelChangeArea)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
    // 初始化选择器控件
    _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/3*2-70, SCREEN_WIDTH-20, SCREEN_HEIGHT/3)];
    _pickerView.alpha = 1;
    _pickerView.clipsToBounds = YES;
    _pickerView.layer.cornerRadius = 5;
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    [self addSubview:_pickerView];
    
    // 获取地区plist文件地址
    NSString * path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
    _dataSource = [NSMutableArray arrayWithContentsOfFile:path];
    
    // 将内容存到字典里 另外两个数组用来存当前键
    for (NSDictionary * dic in _dataSource) {
        NSMutableArray * mArr = [[NSMutableArray alloc]init];
        [_provinceDataSource addObject:[dic objectForKey:@"state"]];
        for (NSDictionary * dic1 in [dic objectForKey:@"cities"]) {
            
            [mArr addObject:[dic1 objectForKey:@"city"]];
        }
        [_dicDataSource setValue:mArr forKey:[dic objectForKey:@"state"]];
    }
    _cityDataSource = [_dicDataSource objectForKey:@"北京"];
    
    // 确定选中
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, SCREEN_HEIGHT-60, SCREEN_WIDTH-20, 50);
    [button setTitle:@"好的" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 5;
    button.alpha = 1;
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button addTarget:self action:@selector(didChangeArea) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
}

- (void)didChangeArea{
    NSInteger firstRow = [_pickerView selectedRowInComponent:0];
    NSInteger subRow = [_pickerView selectedRowInComponent:1];
    if ([_provinceDataSource objectAtIndex:firstRow]&&[_cityDataSource objectAtIndex:subRow]) {
//        areaLabel.text = [NSString stringWithFormat:@"  %@ %@",[provinceData objectAtIndex:firstRow],[subSource objectAtIndex:subRow]];
        self.changeAreaBlock(_cityDataSource[subRow]);
    }
    [self cancelChangeArea];
    
}
- (void)cancelChangeArea{
    self.backgroundColor = [UIColor clearColor];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDidStopSelector:@selector(removeSelfFromSuperView)];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    self.frame = CGRectMake(0, SCREEN_HEIGHT/3 + 70, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
   
}
- (void)removeSelfFromSuperView{
     [self removeFromSuperview];
}
#pragma mark --------------UIPickerViewDelegate
//pickerView列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _dataSource.count;
    }
    return _cityDataSource.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        
        _cityDataSource = [_dicDataSource objectForKey:[_provinceDataSource objectAtIndex:row]];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
        
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return (SCREEN_WIDTH-20)/2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [_provinceDataSource objectAtIndex:row];
    }else{
        return [_cityDataSource objectAtIndex:row];
    }
}
@end

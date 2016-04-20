//
//  HJAreaPickerView.m
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJAreaPickerView.h"
#import "Macro.h"

#define BEGAIN_RECT CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT/3 + 70)       //开始的位置
#define END_RECT CGRectMake(0, SCREEN_HEIGHT/3*2 - 70, SCREEN_WIDTH, SCREEN_HEIGHT/3 + 70)       //结束的位置

@implementation HJAreaPickerView

- (instancetype)initWithArea:(void(^)(NSString *province, NSString *city))area
{
    self = [super init];
    if (self) {
        self.changeAreaBlock = area;
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
}

// 选择器父视图
- (UIView *)superView{
    if (!_superView) {
        _superView = [[UIView alloc]init];
        _superView.frame = BEGAIN_RECT;
        [_superView addSubview:self.pickerView];
        [_superView addSubview:self.okBtn];
    }
    return _superView;
}

// 选择器
- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, SCREEN_HEIGHT/3)];
        _pickerView.alpha = 1;
        _pickerView.clipsToBounds = YES;
        _pickerView.layer.cornerRadius = 5;
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

// 确定按钮
- (UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.frame = CGRectMake(10, SCREEN_HEIGHT/3 + 10, SCREEN_WIDTH-20, 50);
        [_okBtn setTitle:@"好的" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _okBtn.backgroundColor = [UIColor whiteColor];
        _okBtn.layer.cornerRadius = 5;
        _okBtn.alpha = 1;
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_okBtn addTarget:self action:@selector(didChangeArea) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _okBtn;
}

// 手势
- (UITapGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelChangeArea)];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
    }
    return _tap;
}

// 当前窗口
- (UIWindow *)window{
    if (!_window) {
        _window = [UIApplication sharedApplication].keyWindow;
    }
    return _window;
}

// 初始化界面
- (void)createUI{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [UIColor colorWithHue:0.1 saturation:0.1 brightness:0.1 alpha:0.5];
    [self addGestureRecognizer:self.tap];
    [self addSubview:self.superView];
    [self.window addSubview:self];
    
    [self pickerViewAppear];
}

- (void)didChangeArea{
    NSInteger firstRow = [_pickerView selectedRowInComponent:0];
    NSInteger subRow = [_pickerView selectedRowInComponent:1];
    if ([_provinceDataSource objectAtIndex:firstRow]&&[_cityDataSource objectAtIndex:subRow]) {
//        areaLabel.text = [NSString stringWithFormat:@"  %@ %@",[provinceData objectAtIndex:firstRow],[subSource objectAtIndex:subRow]];
        self.changeAreaBlock(_provinceDataSource[firstRow],_cityDataSource[subRow]);
    }
    
    [self cancelChangeArea];
    
}

- (void)pickerViewAppear{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    self.superView.frame = END_RECT;
    [UIView commitAnimations];
}

- (void)cancelChangeArea{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDidStopSelector:@selector(removeSelfFromSuperView)];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    self.superView.frame = BEGAIN_RECT;
    [UIView commitAnimations];
   
}

// 将自己从父视图移除
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

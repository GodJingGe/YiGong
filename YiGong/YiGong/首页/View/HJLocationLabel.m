//
//  HJLocationLabel.m
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJLocationLabel.h"

@implementation HJLocationLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    self.frame = CGRectMake(40, 10, 50, 24);
    self.font = [UIFont systemFontOfSize:16];
    self.textColor = [UIColor whiteColor];
    self.textAlignment = NSTextAlignmentLeft;
    [self locate];
}
- (void)locate

{
    // 判断定位操作是否被允许
    
    if([CLLocationManager locationServicesEnabled]) {
        
        self.locationManager = [[CLLocationManager alloc] init] ;
        
        self.locationManager.delegate = self;
        
    }else {
        
        //提示用户无法进行定位操作
        
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位不成功，请确定开启定位" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [alertVC addAction:okAction];
        [[self getCurrentViewController] presentViewController:alertVC animated:YES completion:nil];
        
    }
    // 开始定位

    [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
}

//定位回调方法
#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    
    CLLocation *currentLocation = [locations lastObject];
    
    // 获取当前所在的城市名
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    //根据经纬度反向地理编译出地址信息
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     
     {
         if (array.count > 0){
             
             CLPlacemark *placemark = [array objectAtIndex:0];
             //将获得的所有信息显示到label上
             //获取城市
             NSString * city;
             
             if (!placemark.locality) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = [NSString stringWithFormat:@"%@",placemark.administrativeArea];
             } else {
                 
                 city = [NSString stringWithFormat:@"%@",placemark.locality];
                 
             }
             ;
             NSString * cityStr = [city substringWithRange:NSMakeRange(0, city.length - 1)];
             self.text = cityStr;
         }
         else if (error == nil && [array count] == 0){
             
             HJLog(@"No results were returned.");
             
         }
         else if (error != nil){
             
             HJLog(@"An error occurred = %@", error);
             
         }
     }];
    
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    
    [manager stopUpdatingLocation];
    
}

// 定位失败回调方法

- (void)locationManager:(CLLocationManager *)manager

       didFailWithError:(NSError *)error {
    
    if (error.code == kCLErrorDenied) {
        
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
        HJLog(@"%ld",(long)error.code);
    }
    
}

// 获取当前视图所在的试图控制器
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}
@end

//
//  HJLocationLabel.h
//  YiGong
//
//  Created by 黄靖 on 16/3/30.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface HJLocationLabel : UILabel<CLLocationManagerDelegate>
/** 定位对象*/
@property(nonatomic, strong) CLLocationManager *locationManager;

@end

//
//  HJCMWViewController.h
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#import "HJRootViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface HJCMWViewController : HJRootViewController<CLLocationManagerDelegate>
/** 定位对象*/
@property(nonatomic, retain) CLLocationManager *locationManager;

@end

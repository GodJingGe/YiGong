//
//  Macro.h
//  YiGong
//
//  Created by 黄靖 on 16/3/25.
//  Copyright © 2016年 易工科技. All rights reserved.
//

#ifndef Macro_h
#define Macro_h
// 判断当前设备是iphone还是ipad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 计算当前屏幕宽和高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 自定义将RGB转换成UIColor
#define HJRGBA(r,g,b,a)  [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define THEME_COLOR HJRGBA(248, 97, 111, 1.0)       // 主题色
#define BG_COLOR HJRGBA(240, 239, 245, 1.0)       // 通用背景色

/**
 *  请求地址
 */
#define COMMON_URL @"http://192.168.0.104:7080/aihu_web/appzzy2/%@"
#define COMMON_IMAGE_URL @"http://192.168.0.104:7080/aihu_web/uploadFiles/uploadImgs/%@"
#endif /* Macro_h */

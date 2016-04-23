//
//  HJRequestTool.h
//  AINursing
//
//  Created by 黄靖 on 16/3/17.
//  Copyright © 2016年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD.h>
@interface HJRequestTool : NSObject
/** 提示框*/
@property(nonatomic, strong) MBProgressHUD *hud;
- (void)netWorkStatus;

- (void)JSONDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail;

- (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

- (void)postFileWithUrl:(NSString *)urlStr file:(NSMutableArray *)files parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError * error))fail;

- (void)showLoadingHudWithTitle:(NSString *)text OnView:(UIView *)view;

- (void)showHudWithText:(NSString *)text Time:(NSInteger)time OnView:(UIView *)view;
@end

//
//  HJRequestTool.h
//  AINursing
//
//  Created by 黄靖 on 16/3/17.
//  Copyright © 2016年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJRequestTool : NSObject

- (void)netWorkStatus;

- (void)JSONDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail;

- (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

- (void)postFileWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail;

@end

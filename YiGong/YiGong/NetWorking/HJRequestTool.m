//
//  HJRequestTool.m
//  AINursing
//
//  Created by 黄靖 on 16/3/17.
//  Copyright © 2016年 黄靖. All rights reserved.
//

#import "HJRequestTool.h"
@implementation HJRequestTool

//检查网络状态
- (void)netWorkStatus
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld", (long)status);
    }];
}
/**
 *  GET请求
 *
 *  @param url     请求地址
 *  @param success 请求成功回调
 *  @param fail    请求失败回调
 */
- (void)JSONDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)())fail
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *dict = @{@"format": @"json"};
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail();
    }];
}

/**
 *  POST请求数据
 *
 *  @param urlStr     请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param fail       请求失败回调
 */

- (void)postJSONWithUrl:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError *error))fail
{
   AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    // 设置请求格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    x-www-form-urlencoded
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    HJLog(@"Loading...");
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        success(responseObject);
        HJLog(@"success!");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        fail(error);
        
    }];
}

/**
 *  上传图片
 *
 *  @param urlStr     请求地址
 *  @param files      上传的文件数组
 *  @param parameters 请求参数
 *  @param success    请求成功回调
 *  @param fail       请求失败回调
 */

- (void)postFileWithUrl:(NSString *)urlStr file:(NSMutableArray *)files parameters:(id)parameters success:(void (^)(id responseObject))success fail:(void (^)(NSError * error))fail{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    // 设置请求格式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"form-data"];
    
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for ( int i = 0; i < files.count ; i ++) {
            NSString * name =[NSString stringWithFormat:@"file%d",i];
            NSData * data = [parameters objectForKey:name];
            [formData appendPartWithFileData:data name:name fileName:@"avatar.png" mimeType:@"image/png"];
        }
        
    
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {

            fail(error);
        
        }];
    
}

@end

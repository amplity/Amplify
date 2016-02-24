//
//  BaseServicesManager.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseServicesManager.h"


//static NSString * const BaseUrl = @"www.baidu.com";
//static NSString * const BaseUrl = @"http://api.harmay.com/router/";
static NSString * const BaseUrl = @"http://test1.harmay.com/router/";

@implementation BaseServicesManager


+(instancetype)instanceServicesManager{
    static BaseServicesManager *instanceBaseServicesManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceBaseServicesManager = [[BaseServicesManager alloc] initWithBaseURL:[NSURL URLWithString:BaseUrl] sessionConfiguration:nil];
        instanceBaseServicesManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return instanceBaseServicesManager;
}

+(void)netWorkStatus{
    
}

+(NSURLSessionDataTask*)getDataWithUrl:(NSString *)urlStr withSuccess:(void (^)(id))success withFail:(void (^)())fail{
    BaseServicesManager * baseServicesManager = [BaseServicesManager instanceServicesManager];
    baseServicesManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSURLSessionDataTask * sessionDataTask = [baseServicesManager GET:urlStr parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        DLog(@"当前进度%@",[NSProgress currentProgress]);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"获取成功%@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"获取失败%@",error);
        fail();
    }];
    
    return sessionDataTask;
}


+(NSURLSessionDataTask*)postDataWithUrl:(NSString*)urlStr withParameters:(NSDictionary*)parameters withSuccess:(void(^)(id responseObj))success withFail:(void(^)())fail{
    BaseServicesManager * baseServicesManager = [BaseServicesManager instanceServicesManager];
    baseServicesManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSURLSessionDataTask * sessionDataTask = [baseServicesManager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"当前进度%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"获取成功%@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"获取失败%@",error);
        fail();
    }];
    
    return sessionDataTask;
}


+ (void)putRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    
    BaseServicesManager * baseServicesManager = [BaseServicesManager instanceServicesManager];
    
    [baseServicesManager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
}

+ (void)deleteRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler {
    
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    BaseServicesManager * baseServicesManager = [BaseServicesManager instanceServicesManager];
    
    [baseServicesManager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
}

/**
 下载文件，监听下载进度
 */
+ (void)downloadRequest:(NSString *)url successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler {
    
    if (![self checkNetworkStatus]) {
        progressHandler(0, 0, 0);
        completionHandler(nil, nil);
        return;
    }
    BaseServicesManager * baseServicesManager = [BaseServicesManager instanceServicesManager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    
    [baseServicesManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        DLog(@"");
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        DLog(@"");
        return targetPath;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completionHandler(response,error);
    }];
}



/**
 上传文件，监听上传进度
 */
+ (void)updateRequest:(NSString *)url params:(NSDictionary *)params successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler {
    
    if (![self checkNetworkStatus]) {
        progressHandler(0, 0, 0);
        completionHandler(nil, nil);
        return;
    }
    
    
    BaseServicesManager * baseServicesManager = [BaseServicesManager instanceServicesManager];
    NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [baseServicesManager uploadTaskWithRequest:urlRequest fromData:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"");
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        DLog(@"");
    }];
    
    
}


/**
 监控网络状态
 */
+ (BOOL)checkNetworkStatus {
    
    __block BOOL isNetworkUse = YES;
    
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown) {
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            isNetworkUse = YES;
        } else if (status == AFNetworkReachabilityStatusNotReachable){
            // 网络异常操作
            isNetworkUse = NO;
            DLog(@"网络异常,请检查网络是否可用！");
        }
    }];
    [reachabilityManager startMonitoring];
    return isNetworkUse;
}
@end




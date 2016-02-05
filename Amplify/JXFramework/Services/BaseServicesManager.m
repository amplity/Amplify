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
@end

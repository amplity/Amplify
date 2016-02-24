//
//  BaseServicesManager.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/**
 请求成功block
 */
typedef void (^requestSuccessBlock)(id responseObj);

/**
 请求失败block
 */
typedef void (^requestFailureBlock) (NSError *error);

/**
 请求响应block
 */
typedef void (^responseBlock)(id dataObj, NSError *error);

/**
 监听进度响应block
 */
typedef void (^progressBlock)(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite);


@interface BaseServicesManager : AFHTTPSessionManager

+(instancetype)instanceServicesManager;

+ (void)netWorkStatus;


/**
 *  get请求
 *
 *  @param urlStr  url
 *  @param success 成功block
 *  @param fail    失败block
 */
+(NSURLSessionDataTask*)getDataWithUrl:(NSString*)urlStr withSuccess:(void(^)(id responseObj))success withFail:(void(^)())fail;


/**
 *  post请求
 *
 *  @param urlStr     url
 *  @param parameters 成功block
 *  @param fail       失败block
 */
+(NSURLSessionDataTask*)postDataWithUrl:(NSString*)urlStr withParameters:(NSDictionary*)parameters withSuccess:(void(^)(id responseObj))success withFail:(void(^)())fail;


/**
 PUT请求
 */
+ (void)putRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;

/**
 DELETE请求
 */
+ (void)deleteRequest:(NSString *)url params:(NSDictionary *)params success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler;

/**
 下载文件，监听下载进度
 */
+ (void)downloadRequest:(NSString *)url successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler;


/**
 文件上传，监听上传进度
 */
+ (void)updateRequest:(NSString *)url params:(NSDictionary *)params successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler;



/**
 监控网络状态
 */
+ (BOOL)checkNetworkStatus;


@end



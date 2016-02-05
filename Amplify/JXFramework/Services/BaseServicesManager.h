//
//  BaseServicesManager.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

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

@end

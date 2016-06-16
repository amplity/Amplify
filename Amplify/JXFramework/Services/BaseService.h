//
//  BaseService.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseServicesManager.h"

@interface BaseService : NSObject


+(instancetype)instanceService;


/**
 *  get请求
 *
 *  @param urlStr  url
 *  @param success 成功block
 *  @param fail    失败block
 */
+(void)getDataWithUrl:(NSString*)urlStr withParameters:(id)parameters withSuccess:(requestSuccessBlock)success withFail:(requestFailureBlock)fail;


/**
 *  post请求
 *
 *  @param urlStr     url
 *  @param parameters 成功block
 *  @param fail       失败block
 */
+(void)postDataWithUrl:(NSString*)urlStr withParameters:(id)parameters withSuccess:(requestSuccessBlock)success withFail:(requestFailureBlock)fail;


/**
 *  上传
 *
 *  @param url               服务端url
 *  @param file              file本地地址
 *  @param progressHandler   进度
 *  @param completionHandler 完成
 */
+ (void)upLoadRequest:(NSString *)url withFile:(NSString*)file  withSuccessAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler;

+(void)upLoadForDataRequest:(NSString *)url withFile:(NSString*)fileName withSuccess:(requestSuccessBlock)success withFail:(requestFailureBlock)fail;

+(void)upLoadForImageRequest:(NSString *)url withImage:(UIImage*)image withSuccess:(requestSuccessBlock)success withFail:(requestFailureBlock)fail;
@end

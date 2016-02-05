//
//  BaseService.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseService : NSObject


+(instancetype)instanceService;


/**
 *  get请求
 *
 *  @param urlStr  url
 *  @param success 成功block
 *  @param fail    失败block
 */
+(void)getDataWithUrl:(NSString*)urlStr withSuccess:(void(^)(id responseObj))success withFail:(void(^)())fail;


/**
 *  post请求
 *
 *  @param urlStr     url
 *  @param parameters 成功block
 *  @param fail       失败block
 */
+(void)postDataWithUrl:(NSString*)urlStr withParameters:(NSDictionary*)parameters withSuccess:(void(^)(id responseObj))success withFail:(void(^)())fail;
@end

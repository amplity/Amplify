//
//  BaseService.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseService.h"

@implementation BaseService

+(instancetype)instanceService{
    
    static BaseService * shareService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareService = [[BaseService alloc] init];
    });
    
    return shareService;
}


+(void)getDataWithUrl:(NSString*)urlStr withParameters:(id)parameters withSuccess:(requestSuccessBlock)success withFail:(requestFailureBlock)fail{
    [BaseServicesManager getDataWithUrl:urlStr withParameters:(id)parameters withSuccess:success withFail:fail];
}


+(void)postDataWithUrl:(NSString*)urlStr withParameters:(id)parameters withSuccess:(requestSuccessBlock)success withFail:(requestFailureBlock)fail{
    [BaseServicesManager postDataWithUrl:urlStr withParameters:parameters withSuccess:success withFail:fail];
}

+ (void)upLoadRequest:(NSString *)url withFile:(NSString*)file  withSuccessAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler{
    [BaseServicesManager upLoadRequest:url withFile:file successAndProgress:progressHandler complete:completionHandler];
}

+(void)upLoadForDataRequest:(NSString *)url withFile:(NSString*)fileName withSuccess:(requestSuccessBlock)success withFail:(requestFailureBlock)fail{
    [BaseServicesManager upLoadForDataRequest:url withFile:fileName success:success failure:fail];
}

+(void)upLoadForImageRequest:(NSString *)url withImage:(UIImage*)image withSuccess:(requestSuccessBlock)success withFail:(requestFailureBlock)fail{
    [BaseServicesManager upLoadForImageRequest:url withImage:image success:success failure:fail];
}

@end

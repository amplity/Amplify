//
//  BaseService.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseService.h"
#import "BaseServicesManager.h"

@implementation BaseService

+(instancetype)instanceService{
    
    static BaseService * shareService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareService = [[BaseService alloc] init];
    });
    
    return shareService;
}


+(void)getDataWithUrl:(NSString *)urlStr withSuccess:(void (^)(id))success withFail:(void (^)())fail{
    [BaseServicesManager getDataWithUrl:urlStr withSuccess:success withFail:fail];
}


+(void)postDataWithUrl:(NSString*)urlStr withParameters:(NSDictionary*)parameters withSuccess:(void(^)(id responseObj))success withFail:(void(^)())fail{
    [BaseServicesManager postDataWithUrl:urlStr withParameters:parameters withSuccess:success withFail:fail];
}

@end

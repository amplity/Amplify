
//  BaseServicesManager.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseServicesManager.h"
#import "UserManager.h"
#import "TipManager.h"
#import "MBProgressHUD.h"


//static NSString * const BaseUrl = @"www.baidu.com";
//static NSString * const BaseUrl = @"http://api.harmay.com/router/";
//static NSString * const BaseUrl = @"http://test1.harmay.com/router/";
//static NSString * const BaseUrl  = @"http://192.168.30.234/router/";
static NSString * const BaseUrl  = @"http://www.harmay.com/router/";
//static NSString * const BaseUrl  = @"http://192.168.30.2/router/";

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

+(NSURLSessionDataTask*)getDataWithUrl:(NSString *)urlStr withParameters:(id)parameters withSuccess:(void (^)(id))success withFail:(void (^)())fail{
    BaseServicesManager * baseServicesManager = [BaseServicesManager instanceServicesManager];
    baseServicesManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSURLSessionDataTask * sessionDataTask = [baseServicesManager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        DLog(@"当前进度%@",[NSProgress currentProgress]);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"获取成功%@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"获取失败%@",error);
        fail(error);
    }];
    
    return sessionDataTask;
}


+(NSURLSessionDataTask*)postDataWithUrl:(NSString*)urlStr withParameters:(NSDictionary*)parameters withSuccess:(void(^)(id responseObj))success withFail:(void(^)())fail{
    BaseServicesManager * baseServicesManager = [BaseServicesManager instanceServicesManager];
    baseServicesManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    NSDictionary * combinParameters = [baseServicesManager combinParameters:parameters];
    NSURLSessionDataTask * sessionDataTask = [baseServicesManager POST:urlStr parameters:combinParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"当前进度%f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"获取成功%@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"获取失败%@",error);
        fail(error);
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
+ (void)upLoadRequest:(NSString *)url withFile:(NSString*)file successAndProgress:(progressBlock)progressHandler complete:(responseBlock)completionHandler {
    
    if (![self checkNetworkStatus]) {
        progressHandler(0, 0, 0);
        completionHandler(nil, nil);
        return;
    }
    
    BaseServicesManager * baseServicesManager = [BaseServicesManager instanceServicesManager];
    NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:file withExtension:nil];
    [baseServicesManager uploadTaskWithRequest:urlRequest fromFile:fileURL progress:^(NSProgress * _Nonnull uploadProgress) {
        DLog(@"");
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        DLog(@"");
    }];
    
}


+(void)upLoadForDataRequest:(NSString *)url withFile:(NSString*)file success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    
    BaseServicesManager * baseServicesManager = [BaseServicesManager instanceServicesManager];
//    NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:file withExtension:nil];
    
    
    [baseServicesManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        
        [formData appendPartWithFileURL:fileURL name:@"file" fileName:fileName mimeType:@"image/jpeg" error:NULL];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
    }];
    
}

+(void)upLoadForImageRequest:(NSString *)url withImage:(UIImage*)image success:(requestSuccessBlock)successHandler failure:(requestFailureBlock)failureHandler{
    if (![self checkNetworkStatus]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // Set the bar determinate mode to show task progress.
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;

    hud.labelText = @"请稍后...";
    
    
    
    BaseServicesManager * baseServicesManager = [BaseServicesManager instanceServicesManager];
    [baseServicesManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
//        NSData *data = UIImagePNGRepresentation(image);
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Instead we could have also passed a reference to the HUD
            // to the HUD to myProgressTask as a method parameter.
            
            DLog(@"%lld",uploadProgress.completedUnitCount);
            DLog(@"%lld",uploadProgress.totalUnitCount)
            NSString *strDistance=[NSString stringWithFormat:@"%.2f", 1.0* uploadProgress.completedUnitCount/uploadProgress.totalUnitCount];
            [MBProgressHUD HUDForView:[UIApplication sharedApplication].keyWindow].progress = strDistance.floatValue;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
        [hud hide:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureHandler(error);
        [hud hide:YES];
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
            [TipManager showTipsWithInforStr:@"网络异常,请检查网络是否可用！" withAfter:1.0];
            
        }
    }];
    [reachabilityManager startMonitoring];
    return isNetworkUse;
}


- (NSDictionary *)combinParameters:(NSDictionary *)params
{
    return  @{
              @"requestHead": @{@"platform":@"iOS", @"version":@"1.1",@"token":[UserManager token]},
              @"requestBody": params
              };
    
//    return  @{
//              @"requestHead": @{@"platform":@"iOS", @"version":@"1.1",@"token":@"ODM0MzUwM2VNWHd4TkRReE5qSXdOelF4TVRVM05EVjhNVGcxTVRneE16UXlNalY4TVRRMU1qVTJORGM0TnpBd01BPT00ZmFkNTg5ODc4MjNhNTdmMDhiYmRkYjQ%3D"},
//              @"requestBody": params
//              };
}
@end




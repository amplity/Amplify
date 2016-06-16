//
//  HomeService.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/23.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "HomeService.h"

@implementation HomeService

+(void)getHomePageUrl:(requestSuccessBlock)handler withFail:(requestFailureBlock)failHandler{
    
    [BaseService getDataWithUrl:@"getScoutUrl" withParameters:nil withSuccess:handler withFail:failHandler];
}
@end

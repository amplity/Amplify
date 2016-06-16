//
//  LookForService.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/24.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "LookForService.h"

@implementation LookForService


+(void)lookForShare:(NSString*)businessId  withType:(NSString*)type withChannel:(NSString*)channel withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    [BaseService postDataWithUrl:@"rest/getShareMsg" withParameters:@{@"businessId":businessId,@"type":type,@"channel":channel} withSuccess:handler withFail:failHandler];
}
@end

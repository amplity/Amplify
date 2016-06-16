//
//  DiscoveryService.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/14.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "DiscoveryService.h"

@implementation DiscoveryService


+(void)getDiscoveryPageUrl:(requestSuccessBlock)handler withFail:(requestFailureBlock)failHandler{
    
    [BaseService getDataWithUrl:@"getDiscoveryIndex" withParameters:nil withSuccess:handler withFail:failHandler];
}

+(void)getHotDiscoverSearch:(requestSuccessBlock)handler withFail:(requestFailureBlock)failHandler{
    [BaseService getDataWithUrl:@"hotword" withParameters:nil withSuccess:handler withFail:failHandler];
}

+(void)queryDiscoverGoodList:(requestSuccessBlock)handler withFail:(requestFailureBlock)failHandler{
    [BaseService getDataWithUrl:@"search" withParameters:nil withSuccess:handler withFail:failHandler];
}

+(void) queryWords:(NSString *) word withSucess:(requestSuccessBlock)handler withFail:(requestFailureBlock)failHandler{
    [BaseService getDataWithUrl:[NSString stringWithFormat:@"spellcheck/%@", word] withParameters:nil withSuccess:handler withFail:failHandler];
}
//加入化妆包，获取url

+(void)addShopGetUrl:(NSString *)productId withSkuId:(NSString *)skuId withNum:(NSString *)num withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;{
    [BaseService postDataWithUrl:@"rest/trolleyc/add" withParameters:@{@"productId":productId,@"skuId":skuId,@"num":num} withSuccess:handler withFail:failHandler];
}

+(void)likeGood:(NSString*)productId withState:(BOOL)state withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    NSString * stateStr = state ? @"1":@"0";
    
    [BaseService postDataWithUrl:@"rest/member/like" withParameters:@{@"productId":productId,@"state":stateStr} withSuccess:handler withFail:failHandler];
}



+(void)payChangeForSend:(NSString *)orderId withCashChannel:(NSString *)cashChannel withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    [BaseService postDataWithUrl:@"rest/order/payorder" withParameters:@{@"orderId":orderId,@"cashChannel":cashChannel} withSuccess:handler withFail:failHandler];
}
@end

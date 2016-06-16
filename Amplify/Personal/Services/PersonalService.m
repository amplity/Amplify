//
//  PersonalService.m
//  Amplify
//
//  Created by ZhangJixu on 16/5/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "PersonalService.h"
#import "BaseService.h"

@implementation PersonalService

+(void)getSettlementList:(NSString *)productId withSkuId:(NSString *)skuId withNum:(NSString *)num withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    
    [BaseService postDataWithUrl:@"rest/order/purchaseNow" withParameters:@{@"productId":productId,@"skuId":skuId,@"num":num} withSuccess:handler withFail:failHandler];
}


+(void)useJfMemuber:(NSString*)jfPrice withLogisticesId:(NSString*)logisticesId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    [BaseService postDataWithUrl:@"rest/order/changeOrder" withParameters:@{@"jfPrice":jfPrice,@"logisticesId":logisticesId} withSuccess:handler withFail:failHandler];
}


+(void)paySend:(NSString *)addressId withType:(NSString*)type withStatus:(NSString*)status withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    
    [BaseService postDataWithUrl:@"rest/order/create" withParameters:@{@"addressId":addressId,@"type":type,@"status":status} withSuccess:handler withFail:failHandler];
}

+(void)payChangeForSend:(NSString *)orderId withCashChannel:(NSString *)cashChannel withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    
    [BaseService postDataWithUrl:@"rest/order/payorder" withParameters:@{@"orderId":orderId,@"cashChannel":cashChannel} withSuccess:handler withFail:failHandler];
}


@end

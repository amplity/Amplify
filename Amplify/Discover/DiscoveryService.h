//
//  DiscoveryService.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/14.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseService.h"

@interface DiscoveryService : BaseService


/**
 *  获得主页url链接
 */
+ (void)getDiscoveryPageUrl:(requestSuccessBlock)handler withFail:(requestFailureBlock)failHandler;

+ (void)getHotDiscoverSearch:(requestSuccessBlock)handler withFail:(requestFailureBlock)failHandler;

+ (void)queryDiscoverGoodList:(requestSuccessBlock)handler withFail:(requestFailureBlock)failHandler;

+ (void)addShopGetUrl:(NSString *)productId withSkuId:(NSString *)skuId withNum:(NSString *)num withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;

+ (void)likeGood:(NSString *)productId withState:(BOOL)state withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;

+ (void)queryWords:(NSString *)word withSucess:(requestSuccessBlock)handler withFail:(requestFailureBlock)failHandler;

/**
 *  ping++ 支付
 *
 *  @param orderId
 *  @param cashChannel
 *  @param handler
 *  @param failHandler 
 */
+ (void)payChangeForSend:(NSString *)orderId withCashChannel:(NSString *)cashChannel withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;

@end

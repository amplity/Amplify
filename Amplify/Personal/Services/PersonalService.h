//
//  PersonalService.h
//  Amplify
//
//  Created by ZhangJixu on 16/5/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseService.h"

@interface PersonalService : BaseService

+(void)getSettlementList:(NSString *)productId withSkuId:(NSString *)skuId withNum:(NSString *)num withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;


+(void)useJfMemuber:(NSString*)jfPrice withLogisticesId:(NSString*)logisticesId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;

/**
 *  提交订单
 *
 *  @param addressId   地址id
 *  @param type        支付类型
 *  @param status      支付类型，是否在app端没有安装
 *  @param handler
 *  @param failHandler
 */
+(void)paySend:(NSString *)addressId withType:(NSString*)type withStatus:(NSString*)status withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;

+(void)payChangeForSend:(NSString *)orderId withCashChannel:(NSString *)cashChannel withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;

@end

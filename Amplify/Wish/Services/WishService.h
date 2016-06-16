//
//  WishService.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/22.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseService.h"

typedef enum{
    // 1 过期心愿  2下期心愿  3本期心愿 4 我参与的
    //5已经结束的
    WishED = 1,
    WishNext = 2,
    WishCurent = 3,
    WishJoin = 4,
    WishEnd = 5
}WISHSTATUS;
@interface WishService : BaseService

//图片上传
+(void)UploadImageForWish:(UIImage*)image witWishId:(NSString*)wishId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;


/**
 *  心愿url
 *
 *  @param status      心愿状态
 *  @param handler     成功
 *  @param failHandler 失败
 */
+(void)getListwish:(NSInteger)status withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;


/**
 *  上传状态信息
 *
 *  @param wishId      wishId
 *  @param handler
 *  @param failHandler 
 */
+(void)upinfo:(NSString*)wishId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;



/**
 *  新增地址，获得订单号
 *
 *  @param name        收件人
 *  @param phone       电话
 *  @param address     地址
 *  @param regioncode  地址code
 *  @param handler
 *  @param failHandler
 */
+(void)addNewAddressForWish:(NSString*)name withPhone:(NSString*)phone withAddress:(NSString*)address withRegioncode:(NSString*)regioncode withWishId:(NSString*)wishId withComId:(NSString*)comId withAddressId:(NSString*)addressId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;


/**
 *  心愿分享
 *
 *  @param wishId
 *  @param type
 *  @param channel
 *  @param handler
 *  @param failHandler
 *"wishId": "145688441764728",  //分享数据id
 "type": "1",      //1活动，2获奖
 "channel": "1"     //1.新浪微博  2.微信 3.qq空间 4.豆瓣
 */
+(void)wishShare:(NSString*)wishId withType:(NSString*)type withChannel:(NSString*)channel withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;


/**
 *  提醒我
 *
 *  @param wishId      wishId
 *  @param handler
 *  @param failHandler
 */
+(void)remindme:(NSString*)wishId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;



/**
 *  获取地址
 *
 */
+(void)getAddressList:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;

@end

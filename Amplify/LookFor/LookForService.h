//
//  LookForService.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/24.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseService.h"

//跳转类型
typedef enum{
    LookForArticleInside = 1,//内部跳转
    LookForArticleOutside = 0//外部跳转
}LookForUrlType;


//分享类型 1.物色 2.心愿 3.品牌 4.产品
typedef enum{
    LookForShareLookFor = 1,
    LookorrShareWish =2,
}LookForShareType;
@interface LookForService : BaseService


/**
 *  物色分享
 *
 *  @param businessId
 *  @param type
 *  @param channel
 *  @param handler
 *  @param failHandler
 *"businessId": "145688441764728",  //分享数据id
 "type": "1",      //分享类型 1.物色 2.心愿 3.品牌 4.产品
 "channel": "1"     //1.新浪微博  2.微信 3.qq空间 4.豆瓣
 */
+(void)lookForShare:(NSString*)businessId  withType:(NSString*)type withChannel:(NSString*)channel withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;

@end

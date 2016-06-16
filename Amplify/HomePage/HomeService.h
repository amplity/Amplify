//
//  HomeService.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/23.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseService.h"

@interface HomeService : BaseService

/**
 *  获得主页url链接
 */
+(void)getHomePageUrl:(requestSuccessBlock)handler withFail:(requestFailureBlock)failHandler;
@end

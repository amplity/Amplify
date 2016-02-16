//
//  UserManager.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/14.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  整体项目管理，用于通用类
 */
@interface UserManager : NSObject

+(instancetype)shareUserManager;

/**
 *  初次启动
 *
 */
+(BOOL)firstLaunch;


/**
 *  是否登陆
 *
 *  @return <#return value description#>
 */
+(BOOL)isLogin;


/**
 *  登陆成功
 *
 */
+(void)saveLogin;


/**
 *  保存token
 */
+(void)saveToken:(NSString*)tokenStr;


/**
 *  获得token
 *
 *  @return <#return value description#>
 */
+(NSString*)token;


/**
 *  版本信息(项目设置)
 *
 *  @return <#return value description#>
 */
+(NSString*)version;


/**
 *  退出
 */
+(void)quitApp;
@end

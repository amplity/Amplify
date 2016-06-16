//
//  UserManager.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/14.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  登录操作结果代理,回调函数处理上一个页面的的操作
 */
@protocol LoginResultDelegate <NSObject>

-(void)showLoginResult:(BOOL)isSuccess withClickStr:(NSString*)clickStr;

@end

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
+(void)saveFirstLaunch:(BOOL)isFirstLauch;


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



+(void)saveJPushRegistrationId:(NSString*)jpushRegistrationIdStr;
/**
 *  jpush 通知注册Id
 */
+(NSString*)JPushRegistrationId;

//设备唯一id
+(void)savaDeviceId:(NSString*)deviceIdStr;

+(NSString*)deviceId;


/**
 *  保存是否为邀请用户
 */
+(void)saveInviteWish:(BOOL)isInvite;

+(BOOL)inviteWish;


+(void)saveFirstInviteWish:(BOOL)isInvite;
+(BOOL)firstInviteWish;

@end

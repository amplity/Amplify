//
//  ThridPartManager.h
//  Makeup
//
//  Created by Woody Yan on 10/22/14.
//  Copyright (c) 2014 Woody Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface ThridPartManager : NSObject

+ (ThridPartManager *) manager;

//是否安装了微信
-(BOOL)isWeixinInstall;


//是否安装了qq
-(BOOL)isQQInstall;

/**
 *  微信登录
 *
 *  @param dissViewController 登录成功后刷新的页面
 *  @param presentViewController presentingView
 */
-(void)weixinLogin:(UIViewController*)dissViewController withPresentViewController:(UIViewController*)presentViewController;

/**
 *  微博登录
 *
 *  @param dissViewController 登录成功后刷新的页面
 *  @param presentViewController presentingView
 */
-(void)weiboLogin:(UIViewController*)dissViewController withPresentViewController:(UIViewController*)presentViewController;


/**
 *  微信绑定(个人设置页面)
 *
 *  @param presentViewController presentingView
 */
-(void)weixinLoginPersonBind:(UIViewController*)presentViewController;

/**
 *  微博绑定(个人设置页面)
 *  @param presentViewController presentingView
 */
-(void)weiboLoginPersonBind:(UIViewController*)presentViewController;

//微信分享
-(void)weixinShare:(NSString*)title withInfoStr:(NSString*)info withIcon:(NSString*)Icon withUrl:(NSString*)url;

//微信朋友圈分享
-(void)weixinQunShare:(NSString*)title withInfoStr:(NSString*)info withIcon:(NSString*)Icon withUrl:(NSString*)url;

//微博分享
-(void)weboShare:(NSString*)title withInfoStr:(NSString*)info withIcon:(NSString*)Icon withUrl:(NSString*)url;

//qq分享
-(void)qqShare:(NSString*)title withInfoStr:(NSString*)info withIcon:(NSString*)Icon withUrl:(NSString*)url;

@end

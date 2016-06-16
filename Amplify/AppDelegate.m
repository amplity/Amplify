//
//  AppDelegate.m
//  Amplify
//
//  Created by ZhangJixu on 16/1/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "HomTabBarController.h"
#import "BootViewController.h"
#import "ZYWContainerViewController.h"
#import "HomeInfoController.h"
#import "SlideNavigationController.h"
#import <ViewDeck/ViewDeck.h>
#import "BootWebViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
#import <AlipaySDK/AlipaySDK.h>

//极光
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>

//ping++
#import "Pingpp.h"

//美恰
#import <MeiQiaSDK/MQManager.h>


#import "UMengManager.h"

@interface AppDelegate (){
    
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self initUserAgent];
    
    [self setupAppInit];
    
    
    [self jgPushInit:launchOptions];
    
    
    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [UserManager savaDeviceId:adId];
    
    [WXApi registerApp:@"wx42b82fdade8ab3a5"];
    
    
    [ShareSDK registerApp:@"d2c1cb2714e8" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeWechatTimeline),@(SSDKPlatformSubTypeQZone)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo:
                [appInfo SSDKSetupSinaWeiboByAppKey:SinaID appSecret:SinaKey redirectUri:@"http://www.sharesdk.cn" authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:WeChatID
                                      appSecret:WeChatSecret];
                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:QQAppId
                                     appKey:QQAppKey
                                   authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
        
    }];
    
    
    //美恰
    [MQManager initWithAppkey:MeiQiaAppKey completion:^(NSString *clientId, NSError *error) {
    }];
    
    //友盟
    [[UMengManager uMengInstance] setStart];
    
    return YES;
}




-(void)setupAppInit{
    
    UIViewController * startViewController = nil;
    
    if ([UserManager firstLaunch]) {
        //        IIViewDeckLeftController * iiViewDeckLeftController = [[HomeInfoController alloc] init];
        //
        //
        //        IIViewDeckController * iiViewDeckViewController = [[IIViewDeckController alloc] initWithCenterViewController:[[HomTabBarController alloc] init] leftViewController:iiViewDeckLeftController];
        //
        //        iiViewDeckViewController.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
        //
        //        startViewController = iiViewDeckViewController;
        
        //        HomTabBarController *homTabBarController= [[HomTabBarController alloc] init];
        HomTabBarController *homTabBarController = [HomTabBarController shareInstance];
        
        startViewController = homTabBarController;
        
    }else{
        
        startViewController = [[BootWebViewController alloc] init];
    }
    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = startViewController;
    [self.window makeKeyAndVisible];
    
    
}


//极光推送
-(void)jgPushInit:(NSDictionary*)launchOptions{
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:@"64ff6d7e4bc0aa3599b21f69"
                          channel:JPushChannel
                 apsForProduction:NO
            advertisingIdentifier:advertisingId];
}


//默认添加，设备信息
-(void)initUserAgent{
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    NSString *newUagent = [NSString stringWithFormat:@"%@ harmay/2.0.0",oldAgent];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys:newUagent, @"UserAgent", nil, nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [MQManager closeMeiqiaService];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
    
    [MQManager openMeiqiaService];
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
    return canHandleURL;
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];
    
    
    
    //需要判断是否是海外版本，还是ping++
    

    return [Pingpp handleOpenURL:url withCompletion:nil];
}



#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    
    
    return  [Pingpp handleOpenURL:url withCompletion:nil];
}
#endif

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
    
    
    
    //保存registerDeviceID；
    [UserManager saveJPushRegistrationId:[JPUSHService registrationID]];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


@end

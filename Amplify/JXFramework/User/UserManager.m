//
//  UserManager.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/14.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
+(instancetype)shareUserManager{
    static UserManager * userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[UserManager alloc] init];
    });
    
    return userManager;
}

+(BOOL)firstLaunch{
    BOOL fl = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLauch"];
    if (!fl) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLauch"];
    }
    
    return fl;
}

+(void)saveFirstLaunch:(BOOL)isFirstLauch{
    [[NSUserDefaults standardUserDefaults] setBool:isFirstLauch forKey:@"firstLauch"];
}

+(BOOL)isLogin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}

+(void)saveLogin{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
}

+(void)saveToken:(NSString*)tokenStr{
    if (![UserManager isLogin]) {
        [[NSUserDefaults standardUserDefaults] setObject:tokenStr forKey:@"anonymous"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:tokenStr forKey:@"token"];
}

+(NSString*)token{
    NSString * currentToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
    if (!currentToken|| [currentToken isEqualToString:@""]) {
        [UserManager saveToken:@"anonymous"];
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
}


//版本信息
+(NSString*)version{
    NSString* ver = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return ver;
}

+(void)quitApp{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] setObject:@"anonymous" forKey:@"token"];
}


+(void)saveJPushRegistrationId:(NSString*)jpushRegistrationIdStr{
    
    [[NSUserDefaults standardUserDefaults] setObject:jpushRegistrationIdStr forKey:@"JPushRegistrationId"];
}

+(NSString*)JPushRegistrationId{
    NSString * currentJPushRegistrationId = [[NSUserDefaults standardUserDefaults] stringForKey:@"JPushRegistrationId"];
    return currentJPushRegistrationId;
}


//设备唯一id
+(void)savaDeviceId:(NSString*)deviceIdStr{
    [[NSUserDefaults standardUserDefaults] setObject:deviceIdStr forKey:@"deviceId"];
}

+(NSString*)deviceId{
    NSString * deviceIdStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceId"];
    return deviceIdStr;
}

+(void)saveInviteWish:(BOOL)isInvite{
    [[NSUserDefaults standardUserDefaults] setBool:isInvite forKey:@"isInviteWish"];
}

+(BOOL)inviteWish{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isInviteWish"];
}

+(void)saveFirstInviteWish:(BOOL)isInvite{
    [[NSUserDefaults standardUserDefaults] setBool:isInvite forKey:@"firstInviteWish"];
}

+(BOOL)firstInviteWish{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"firstInviteWish"];
}
@end

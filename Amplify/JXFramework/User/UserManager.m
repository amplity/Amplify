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

+(BOOL)isLogin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}

+(void)saveLogin{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
}

+(void)saveToken:(NSString*)tokenStr{
    [[NSUserDefaults standardUserDefaults] setObject:tokenStr forKey:@"token"];
}

+(NSString*)token{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
}


//版本信息
+(NSString*)version{
    NSString* ver = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    return ver;
}

+(void)quitApp{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
}
@end

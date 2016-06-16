//
//  UMengManager.m
//  Amplify
//
//  Created by ZhangJixu on 16/6/14.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "UMengManager.h"
#import <UMMobClick/MobClick.h>

@implementation UMengManager


+(instancetype)uMengInstance{
    
    static UMengManager * umengManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        umengManager = [[UMengManager alloc] init];
    });
    
    return  umengManager;
}

-(void)setStart{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    UMConfigInstance.appKey = UMengAppKey;
    UMConfigInstance.channelId = UMengChannel;
    
    [MobClick startWithConfigure:UMConfigInstance];
}


-(void)beginLogPageView:(NSString *)pageName{
    [MobClick beginLogPageView:pageName];
}


-(void)endLogPageView:(NSString *)pageName{
    [MobClick endLogPageView:pageName];
}

-(void)event:(NSString *)eventId{
    [MobClick event:eventId];
}

-(void)event:(NSString *)eventId label:(NSString *)label{
    [MobClick event:eventId label:label];
}

@end

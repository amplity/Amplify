//
//  LoginBind.h
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/17.
//  Copyright © 2015年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginBind : NSObject
@property (nonatomic) NSString* uid;

@property (nonatomic) NSString* nickname;

@property (nonatomic) NSString* profileUrl;

@property (nonatomic) NSString* gender;


//微信为2，微博为1
@property (nonatomic,copy) NSString* thirdPlatform;

@property (nonatomic,copy) NSString* unionId;

@end

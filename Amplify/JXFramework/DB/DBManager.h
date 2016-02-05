//
//  DBManager.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/4.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject


+(instancetype)shareDBManager;

+ (void)initialize;

+(void)create:(NSString*)sqlStr;

+(void)insert:(NSString*)sqlStr;

+(void)update:(NSString*)sqlStr;

+(void)deleteSql:(NSString*)sqlStr;

+(void)query:(NSString*)sqlStr;

+ (void) connect:(NSString*)dbName;

+ (void) close;
@end

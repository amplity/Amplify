//
//  AmplifyCache.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/24.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AmplifyCache : NSObject

+ (void) resetCache;

+ (void) setObject:(NSData*)data forKey:(NSString*)key;
+ (id) objectForKey:(NSString*)key;

@end

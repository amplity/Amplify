//
//  CacheManager.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/19.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

+(instancetype)shareCacheManager;


/**
 *  归档
 *
 *  @param object 数据类<nsconding>
 */
+(void)saveKeyArchiver:(NSObject*)object;

/**
 *  读档
 *
 *  @param archiverFile 读档文件
 *
 *  @return 数据<nscoding> (和归档同步)
 */
+(NSObject*)getKeyArchiver:(NSString*)archiverFile;

/**
 *  保存到文件
 *
 *  @param fileName 文件夹名
 *  @param object   保存数据对象<nscoding>
 */
-(void)savaObjectToFile:(NSString*)fileName withObject:(NSObject *) object;

/**
 *  获取文件数据
 *
 *  @param fileName 文件名称
 *
 *  @return 数据对象，nsdata（取得后由各自类转换）
 */
-(NSData*)getObjectFormFile:(NSString*)fileName;
@end

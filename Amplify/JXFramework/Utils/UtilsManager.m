//
//  UtilsManager.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/19.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "UtilsManager.h"

@implementation UtilsManager

+(instancetype)shareInstance{
    
    static UtilsManager * utilsManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        utilsManager = [[UtilsManager alloc] init];
    });
    
    return  utilsManager;
}

//通常用于删除缓存的时，计算缓存大小
//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

@end

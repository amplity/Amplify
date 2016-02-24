//
//  CacheManager.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/19.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager

+(instancetype)shareCacheManager{
    
    static CacheManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CacheManager alloc] init];
    });
    
    return instance;
}


//一、关于同一个URL的多次请求
//
//　　有时候，对同一个URL请求多次，返回的数据可能都是一样的，比如服务器上的某张图片，无论下载多少次，返回的数据都是一样的。
//
//　　
//
//　　上面的情况会造成以下问题
//
//（1）用户流量的浪费
//
//（2）程序响应速度不够快
//
//解决上面的问题，一般考虑对数据进行缓存。
//
//
//
//二、缓存
//
//　　为了提高程序的响应速度，可以考虑使用缓存（内存缓存\硬盘缓存）
//
//　　
//
//　　第一次请求数据时，内存缓存中没有数据，硬盘缓存中没有数据。
//
//缓存数据的过程
//
//　　
//
//当服务器返回数据时，需要做以下步骤
//
//（1）使用服务器的数据（比如解析、显示）
//
//（2）将服务器的数据缓存到硬盘（沙盒）
//
//此时缓存的情况是：内存缓存中有数据，硬盘缓存中有数据。
//
//再次请求数据分为两种情况：
//
//（1）如果程序并没有被关闭，一直在运行
//
//　　那么此时内存缓存中有数据，硬盘缓存中有数据。如果此时再次请求数据，直接使用内存缓存中的数据即可
//
//（2）如果程序重新启动
//
//　　那么此时内存缓存已经消失，没有数据，硬盘缓存依旧存在，还有数据。如果此时再次请求数据，需要读取内存中缓存的数据。
//
//提示：从硬盘缓存中读取数据后，内存缓存中又有数据了
//
//
//
//三、缓存的实现
//
//1.说明：
//
//由于GET请求一般用来查询数据，POST请求一般是发大量数据给服务器处理（变动性比较大）
//
//因此一般只对GET请求进行缓存，而不对POST请求进行缓存
//
//　　在iOS中，可以使用NSURLCache类缓存数据
//
//　　iOS 5之前：只支持内存缓存。从iOS 5开始：同时支持内存缓存和硬盘缓存
//
//
//
//2.NSURLCache
//
//iOS中得缓存技术用到了NSURLCache类。
//
//缓存原理：一个NSURLRequest对应一个NSCachedURLResponse
//
//缓存技术：把缓存的数据都保存到数据库中。
//
//
//
//3.NSURLCache的常见用法
//
//（1）获得全局缓存对象（没必要手动创建）NSURLCache *cache = [NSURLCache sharedURLCache];
//
//（2）设置内存缓存的最大容量（字节为单位，默认为512KB）- (void)setMemoryCapacity:(NSUInteger)memoryCapacity;
//
//（3）设置硬盘缓存的最大容量（字节为单位，默认为10M）- (void)setDiskCapacity:(NSUInteger)diskCapacity;
//
//（4）硬盘缓存的位置：沙盒/Library/Caches
//
//（5）取得某个请求的缓存- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request;
//
//（6）清除某个请求的缓存- (void)removeCachedResponseForRequest:(NSURLRequest *)request;
//
//（7）清除所有的缓存- (void)removeAllCachedResponses;
//
//
//
//4.缓存GET请求
//
//　　要想对某个GET请求进行数据缓存，非常简单
//
//　　NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//
//　　// 设置缓存策略
//
//　　request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
//
//　　只要设置了缓存策略，系统会自动利用NSURLCache进行数据缓存
//
//
//
//5.iOS对NSURLRequest提供了7种缓存策略：（实际上能用的只有4种）
//
//NSURLRequestUseProtocolCachePolicy // 默认的缓存策略（取决于协议）
//
//NSURLRequestReloadIgnoringLocalCacheData // 忽略缓存，重新请求
//
//NSURLRequestReloadIgnoringLocalAndRemoteCacheData // 未实现
//
//NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData // 忽略缓存，重新请求
//
//NSURLRequestReturnCacheDataElseLoad// 有缓存就用缓存，没有缓存就重新请求
//
//NSURLRequestReturnCacheDataDontLoad// 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
//
//NSURLRequestReloadRevalidatingCacheData // 未实现
//
//
//
//6.缓存的注意事项
//
//缓存的设置需要根据具体的情况考虑，如果请求某个URL的返回数据：
//
//　　（1）经常更新：不能用缓存！比如股票、彩票数据
//
//　　（2）一成不变：果断用缓存
//
//　　（3）偶尔更新：可以定期更改缓存策略 或者 清除缓存
//
//提示：如果大量使用缓存，会越积越大，建议定期清除缓存

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.创建请求
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8080/YYServer/video"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 2.设置缓存策略(有缓存就用缓存，没有缓存就重新请求)
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    // 3.发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            NSLog(@"%@", dict);
        }
    }];
}

/**
 // 定期处理缓存
 //    if (缓存没有达到7天) {
 //        request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
 //    }
 // 获得全局的缓存对象
 NSURLCache *cache = [NSURLCache sharedURLCache];
 //    if (缓存达到7天) {
 //        [cache removeCachedResponseForRequest:request];
 //    }
 
 // lastCacheDate = 2014-06-30 11:04:30
 
 NSCachedURLResponse *response = [cache cachedResponseForRequest:request];
 if (response) {
 NSLog(@"---这个请求已经存在缓存");
 } else {
 NSLog(@"---这个请求没有缓存");
 }
 */


//--------------------------End----------------------------

//***归档、解档的用法
/**
 *  1.NSKeyedArchiver 归档
 *  2.归档必须遵循NSCoding
 *  3.encodeWithCoder
 *  4.initcodeWithCoder
 *  5.encodeWithCoder、initcodeWithCoder实现键值存储、读取。废除了以前的顺序存放
 */

+(void)saveKeyArchiver:(NSObject*)object{
    //NSDocumentDirectory 缓存document文件夹
    //NSLibraryDirectory 缓存lib文件夹
    NSString * documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    
    NSString * fileSuffix = [NSString stringWithFormat:@"%@.%@",NSStringFromClass(object.class),@"archiver"];
    NSString * fileDirectory = [documentDirectory stringByAppendingPathComponent:fileSuffix];
    
    [NSKeyedArchiver archiveRootObject:object toFile:fileDirectory];
    
}

+(NSObject*)getKeyArchiver:(NSString*)archiverFile{
    NSString * documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileDirectory = [documentDirectory stringByAppendingPathComponent:archiverFile];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:fileDirectory];
}


//----------------------------End-------------------------

-(void)savaObjectToFile:(NSString*)fileName withObject:(NSObject *) object{
    //NSArray,NSDictionary,NSString 可以直接用writeToFile写入文件
    
    NSString * documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileDirectory = [documentDirectory stringByAppendingPathComponent:fileName];
    
    
    
    NSData * archiverData = [NSKeyedArchiver archivedDataWithRootObject:object];
    [[NSFileManager defaultManager] createFileAtPath:fileDirectory contents:archiverData attributes:nil];
}

-(NSData*)getObjectFormFile:(NSString*)fileName{
    NSString * documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileDirectory = [documentDirectory stringByAppendingPathComponent:fileName];
    
    //读取文件
    NSData * fileData = [[NSData alloc] initWithContentsOfFile:fileDirectory];
//    [[NSFileManager defaultManager] contentsAtPath:fileDirectory];
    
    
    return fileData;
}
@end

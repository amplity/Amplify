//
//  DBManager.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/4.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "DBManager.h"
#import "BaseDbData.h"
@implementation DBManager
/** 数据库实例 */
static BaseDbData *_db;

+(instancetype)shareDBManager{
    
    static DBManager * shareDBManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareDBManger = [[DBManager alloc] init];
    });
    
    return shareDBManger;
}

+ (void)initialize
{
    // // 沙盒Docu目录 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"amplify.sqlite"];
    
    // 2.得到数据库
    _db = [BaseDbData databaseWithPath:filename];
    
    // 3.打开数据库
    if ([_db open]) {
//        // 4.创表
//        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_home_status (id integer PRIMARY KEY AUTOINCREMENT, access_token text NOT NULL, status_idstr text NOT NULL, status_dict blob NOT NULL);"];
//        if (result) {
//            NSLog(@"成功创表");
//        } else {
//            NSLog(@"创表失败");
//        }
    }
}


+(void)create:(NSString*)sqlStr
{
    if ([_db open]) {
//        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,ID,NAME,AGE,ADDRESS];
        
        NSString *sqlCreateTable =  sqlStr;
        BOOL res = [_db executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
        
    }
}

+(void)insert:(NSString*)sqlStr
{
    if ([_db open]) {
//        NSString *insertSql1= [NSString stringWithFormat:
//                               @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
//                               TABLENAME, NAME, AGE, ADDRESS, @"张三", @"13", @"济南"];
//        BOOL res = [_db executeUpdate:insertSql1];
//        NSString *insertSql2 = [NSString stringWithFormat:
//                                @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
//                                TABLENAME, NAME, AGE, ADDRESS, @"李四", @"12", @"济南"];
//        BOOL res2 = [_db executeUpdate:insertSql2];
        
        
        NSString *insertSql1= sqlStr;
        BOOL res = [_db executeUpdate:insertSql1];
        
        if (!res) {
            NSLog(@"error when insert db table");
        } else {
            NSLog(@"success to insert db table");
        }
        [_db close];
        
    }
}


+(void)update:(NSString*)sqlStr
{
    if ([_db open]) {
//        NSString *updateSql = [NSString stringWithFormat:
//                               @"UPDATE '%@' SET '%@' = '%@' WHERE '%@' = '%@'",
//                               TABLENAME,   AGE,  @"15" ,AGE,  @"13"];
        
        NSString *updateSql = sqlStr;

        BOOL res = [_db executeUpdate:updateSql];
        if (!res) {
            NSLog(@"error when update db table");
        } else {
            NSLog(@"success to update db table");
        }
        [_db close];
        
    }
}


+(void)deleteSql:(NSString*)sqlStr
{
    if ([_db open]) {
        
//        NSString *deleteSql = [NSString stringWithFormat:
//                               @"delete from %@ where %@ = '%@'",
//                               TABLENAME, NAME, @"张三"];
        
        NSString *deleteSql = sqlStr;
        BOOL res = [_db executeUpdate:deleteSql];
        
        if (!res) {
            NSLog(@"error when delete db table");
        } else {
            NSLog(@"success to delete db table");
        }
        [_db close];
        
    }
}

+(void)query:(NSString*)sqlStr
{
    // 1.执行查询语句
//    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM t_student"];
//    
//    // 2.遍历结果
//    while ([resultSet next]) {
//        int ID = [resultSet intForColumn:@"id"];
//        NSString *name = [resultSet stringForColumn:@"name"];
//        int age = [resultSet intForColumn:@"age"];
//        NSLog(@"%d %@ %d", ID, name, age);
//    }
    
    FMResultSet *resultSet = [_db executeQuery:sqlStr];
    
//    // 2.遍历结果
//    while ([resultSet next]) {
//        int ID = [resultSet intForColumn:@"id"];
//        NSString *name = [resultSet stringForColumn:@"name"];
//        int age = [resultSet intForColumn:@"age"];
//        NSLog(@"%d %@ %d", ID, name, age);
//    }
}

/// 连接数据库
+ (void) connect:(NSString*)dbName {
    if (!_db) {
        _db = [BaseDbData databaseWithPath:dbName];
    }
    if (![_db open]) {
        NSLog(@"不能打开数据库");
    }
}
// 关闭连接
+ (void) close {
    [_db close];
}

@end

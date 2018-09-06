//
//  CacheTool.m
//  CustomerService
//
//  Created by 吴宏佳 on 2018/9/6.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "CacheTool.h"
#import "FMDB.h"

#define CacheFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Cache.sqlite"]

@implementation CacheTool
static FMDatabaseQueue *_queue;

+ (void)initialize
{
    // 0.获得沙盒中的数据库文件名
    NSLog(@"%@",CacheFile);
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:CacheFile];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdateWithFormat:@"CREATE TABLE IF NOT EXISTS message (id integer primary key autoincrement, role TEXT, text TEXT, app_store_url TEXT ,android_url TEXT,time TEXT ,h5_url TEXT)"];
    }];
}
+(void)addBMKPoiInfo:(MsgObj *)poiInfo{
    
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"INSERT  INTO message (role, text, app_store_url , android_url  ,time , h5_url) values('%@','%@','%@','%@','%@','%@')", poiInfo.role,poiInfo.text,poiInfo.app_store_url,poiInfo.android_url,poiInfo.time,poiInfo.h5_url];
        BOOL loob =   [db executeUpdate:sql];
        if (!loob) {
            NSLog(@"数据存储-失败！");
        }
        
    }];
    
}
+(void)deleteBMKPoiInfo{
    [_queue inDatabase:^(FMDatabase *db) {
        // 删除数据
        BOOL loob =  [db executeUpdateWithFormat:@"DELETE FROM message "];
        if (!loob) {
            NSLog(@"数据删除—失败！");
            
        }
    }];
    
}
+ (NSMutableArray<MsgObj*> *)obtainBMKPoiInfos{
    
    // 1.定义数组
    __block NSMutableArray *poiInfos = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        poiInfos = [NSMutableArray array];
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"SELECT * FROM message ORDER BY id   "];
        while (rs.next) {
            MsgObj *poiInfo = [[MsgObj alloc]init];
            poiInfo.role = [rs stringForColumn:@"role"];
            poiInfo.text = [rs stringForColumn:@"text"];
            poiInfo.app_store_url = [rs stringForColumn:@"app_store_url"];
            poiInfo.android_url = [rs stringForColumn:@"android_url"];
            poiInfo.time = [rs stringForColumn:@"time"];
            poiInfo.h5_url = [rs stringForColumn:@"h5_url"];
            poiInfo.isSend = YES;

            [poiInfos addObject:poiInfo];
        }
        
        [rs close];
    }];
    
    // 3.返回数据
    return poiInfos;
}
+ (MsgObj *)obtainBMKPoiInfosLast{
    
    // 1.定义数组
    __block MsgObj *poiInfowai = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        FMResultSet *rs = nil;
        rs = [db executeQuery:@"SELECT * FROM message ORDER BY id DESC LIMIT 1 "];
        if (rs.next) {
            MsgObj *poiInfo = [[MsgObj alloc]init];
            poiInfo.role = [rs stringForColumn:@"role"];
            poiInfo.text = [rs stringForColumn:@"text"];
            poiInfo.app_store_url = [rs stringForColumn:@"app_store_url"];
            poiInfo.android_url = [rs stringForColumn:@"android_url"];
            poiInfo.time = [rs stringForColumn:@"time"];
            poiInfo.h5_url = [rs stringForColumn:@"h5_url"];
            poiInfo.isSend = YES;
            poiInfowai =poiInfo;

        }
        
        [rs close];
    }];
    
    // 3.返回数据
    return poiInfowai;
}


@end

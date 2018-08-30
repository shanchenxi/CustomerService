//
//  CacheTool.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/5/5.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "CacheTool.h"
#import "FMDB.h"


const NSInteger AlbumCacheDBVersion = 1;

static FMDatabaseQueue *_tmpQueue;

@interface CacheTool ()
+ (NSString*)cacheFile;
+ (FMDatabaseQueue*)queue;
+ (FMDatabaseQueue *)tmpQueue;

@end

@implementation CacheTool
+ (void)initialize
{
    
    // 0.获得沙盒中的数据库文件名
    NSLog(@"%@",self.cacheFile);
    [self.tmpQueue inDatabase:^(FMDatabase * _Nonnull db) {

        
    }];
    
    
    [self.queue inDatabase:^(FMDatabase *db) {
        // 2.创表
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTS version (id INTEGER PRIMARY KEY AUTOINCREMENT, number INTEGER)"];
        

        // 3.更新表
        NSString *sql = @"SELECT number FROM version LIMIT 1";
        FMResultSet *rs = [db executeQuery:sql];
        NSInteger number = 0;
        if (rs.next) {
            number = [rs intForColumn:@"number"];
            if (AlbumCacheDBVersion > number ) {
                sql = [NSString stringWithFormat:@"UPDATE version  SET number = %ld",AlbumCacheDBVersion];
                BOOL loob = [db executeUpdate:sql];
                NSLog(@"数据库文件更新-%@",loob? @"成功":@"失败！");

            }
            
        }else{
            sql = [NSString stringWithFormat:@"INSERT INTO version (number) VALUES(%ld)",AlbumCacheDBVersion];
            [db executeUpdate:sql];
        }
        [rs close];
        switch (number) {
            case 0:
                //                [db executeUpdate:[NSString stringWithFormat:@"ALTER TABLE playProgress ADD COLUMN whj INTEGER"]];
                
                break;
                
        }
        
        
    }];
}
+ (NSString*)cacheFile{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"AlbumCache.sqlite"];
}
+ (FMDatabaseQueue *)queue{
    return [FMDatabaseQueue databaseQueueWithPath:self.cacheFile];
}
+ (FMDatabaseQueue *)tmpQueue{
    if (!_tmpQueue) {
        _tmpQueue = [FMDatabaseQueue databaseQueueWithPath:@""];
    }
    return _tmpQueue;
}

#pragma mark - workers相关


@end

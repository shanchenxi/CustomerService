//
//  AccountTool.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/3/25.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "AccountTool.h"
#define AccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation AccountTool
+ (void)setAccount:(id)account{
    if (account) {
        [NSKeyedArchiver archiveRootObject:account toFile:AccountFile];
    }else{
        [self removeAccount];
    }
}
+ (id)account{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:AccountFile];
}

+(BOOL)removeAccount{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL bRet = [fileMgr fileExistsAtPath:AccountFile];
    if (bRet) {
        //
        NSError *err;
        return  [fileMgr removeItemAtPath:AccountFile error:&err];
        
    }
    return bRet;
}

@end

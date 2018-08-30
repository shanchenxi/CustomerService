//
//  AccountTool.h
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/3/25.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountTool : NSObject
/**
 *  存储账号信息  -encodeWithCoder:
 *
 *  @param account 需要存储的账号
 */
+ (void)setAccount:(id)account;

/**
 *  返回存储的账号信息  需要被储存的对象实现-initWithCoder:
 */
+ (id)account;
/**
 *  删除存储的账号信息
 */
+(BOOL)removeAccount;

@end

//
//  MsgObj.h
//  CustomerService
//
//  Created by 吴宏佳 on 2018/9/1.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgObj : NSObject
@property (strong, nonatomic) NSString *role;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *app_store_url;
@property (strong, nonatomic) NSString *android_url;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *h5_url;
@property (assign, nonatomic) BOOL isSend;

@end

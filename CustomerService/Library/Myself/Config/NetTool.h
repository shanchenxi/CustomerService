//
//  NetTool.h
//  Gorgeous
//
//  Created by lyt on 2018/4/25.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetTool : NSObject
+ (NSString*)baseURL;

+ (NSURLSession*)session;

+ (NSURLSessionTask*)GET:(NSString*)urlStr param:(NSDictionary*)param completion:(void(^)(id results))block;

+ (NSURLSessionTask*)POST:(NSString*)urlStr param:(NSDictionary*)param completion:(void(^)(id results))block;

///id  是NSArray或者NSData
+ (NSURLSessionTask*)POST:(NSString*)urlStr param:(NSDictionary*)param thumbDictionary:(NSDictionary<NSString* , id> *)thumbDic completion:(void(^)(id results))block;

@end

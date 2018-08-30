//
//  NetTool.m
//  Gorgeous
//
//  Created by lyt on 2018/4/25.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "NetTool.h"
#import "AFNetworking.h"
@interface NSDictionary (NetTool)
- (NSString*)toQuery;
@end

@implementation NSDictionary (NetTool)
- (NSString*)toQuery{
    NSMutableString *mutStr = [NSMutableString string];
    for (id key in self) {
        [mutStr appendFormat:@"&%@=%@",key,self[key]];
    }
    if (mutStr.length > 0) {
        [mutStr deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    return mutStr;
}

@end

@implementation NetTool
+ (void)initialize{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                
                
                break;
            case AFNetworkReachabilityStatusNotReachable://当前网络不可用
            default:
                [operationQueue setSuspended:YES];
                
                
                break;
        }
        
        
    }];
    [manager.reachabilityManager startMonitoring];
    
}
+ (NSURLSession*)session{
    
    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    return session;
}
+ (NSString*)baseURL{
    return @"http://47.104.234.62/";
}
+ (NSURLSessionTask*)GET:(NSString*)urlStr param:(NSDictionary*)param completion:(void(^)(id results))block{
    NSString *query = nil;
    if (param.count == 0) {
        param = @{};
        query = @"";
    }else{
        query = [NSString stringWithFormat:@"?%@",param.toQuery];
    }
    if (urlStr.length == 0) {
        urlStr = @"";
    }
    urlStr = [NSString stringWithFormat:@"%@%@%@",self.baseURL,urlStr,query];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSessionDataTask * task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        id results = nil;
        NSLog(@"logStart");
        NSLog(@"Request:%@",url);
        NSLog(@"Response:%@",response.URL);
        if (error) {
            NSLog(@"网络错误：%@",error);
            
        }else{
            
            NSError *jsonError = nil;
            if (data && data.length > 0) {
                results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                if (jsonError){
                    NSLog(@"json解析错误：%@",jsonError);
                    results = nil;
                }else{
                    
                }
            }else {
                NSLog(@"返回的数据长度为零");
                
            }
        }
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            if (block){
                block(results);
            }
        }];
        
        NSLog(@"logEnd");
    }];
    [task resume];
    return task;
}
+ (NSURLSessionTask*)POST:(NSString*)urlStr param:(NSDictionary*)param completion:(void(^)(id results))block{
    
    urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL,urlStr];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSLog(@"Request:%@",urlStr);
    NSLog(@"Request:%@",param);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif",@"application/x-javascript",@"application/x-www-form-urlencoded", nil];
    
    return [manager POST:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (block){
            block(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络错误：%@",error);
        if (block) {
            block(nil);
        }
        
    }];
    
}

+ (NSURLSessionTask*)POST:(NSString*)urlStr param:(NSDictionary*)param thumbDictionary:(NSDictionary<NSString* , id> *)thumbDic completion:(void(^)(id results))block{
    if (thumbDic.count==0) {
        return [self POST:urlStr param:param completion:block];
    }else{
        urlStr = [NSString stringWithFormat:@"%@%@",self.baseURL,urlStr];
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSLog(@"Request:%@",urlStr);
        NSLog(@"Request:%@",param);
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif",@"application/x-javascript",@"application/x-www-form-urlencoded", nil];
        
        
        return [manager POST:urlStr parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (NSString* key in thumbDic) {
                id value = thumbDic[key];
                if ([value isKindOfClass:[NSArray class]]) {
                    for (id obj in value) {
                        if ([obj isKindOfClass:[NSData class]]) {
                            [formData appendPartWithFileData:obj name:key fileName:[NSString stringWithFormat:@"%u.png",arc4random()] mimeType:@"image/png"];
                        }else if ([obj isKindOfClass:[NSURL class]]) {
                            NSURL *url = obj;
                            [formData appendPartWithFileURL:obj name:key fileName:url.lastPathComponent mimeType:@"image/png" error:nil];
                        }
                        
                    }
                }else{
                    if ([value isKindOfClass:[NSData class]]) {
                        
                        [formData appendPartWithFileData:value name:key fileName:[NSString stringWithFormat:@"%u.png",arc4random()] mimeType:@"image/png"];
                    }else if ([value isKindOfClass:[NSURL class]]) {
                        NSURL *url = value;
                        [formData appendPartWithFileURL:value name:key fileName:url.lastPathComponent mimeType:@"image/png" error:nil];
                    }
                }
                
            }
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (block){
                block(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"网络错误：%@",error);
            if (block) {
                block(nil);
            }
        }];
    };
    
}
@end

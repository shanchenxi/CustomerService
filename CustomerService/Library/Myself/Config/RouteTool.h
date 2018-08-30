//
//  RouteTool.h
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/14.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <UIKit/UIKit.h>
//本类的urlStr的格式 与 解释
//NSString* path = @"ViewController?key=value#animated";
//animated为1或者0，不传默认为1（YES）
//RouteToolParameter建议创建一个UIViewController基类实现协议

@protocol RouteToolParameter <NSObject>

@required
@property (strong, nonatomic) NSDictionary *param;

@end
@interface UIViewController (RouteTool)
- (UIViewController*)push:(NSString *)urlStr, ... ;
- (UIViewController*)pushWK:(NSString*)reqURLStr route:(NSString *)urlStr, ... ;
- (UIViewController*)present:(NSString *)urlStr, ... ;
- (UIViewController*)pop;
- (void)dismiss;
@end

@interface RouteTool : NSObject
+ (UIViewController*)push:(NSString*)urlStr, ... ;
+ (UIViewController*)push:(NSString *)urlStr param:(NSDictionary*)param;
+ (UIViewController*)push:(NSString*)urlStr nav:(UINavigationController*)nav;
+ (UIViewController*)push:(NSString *)urlStr param:(NSDictionary*)param nav:(UINavigationController *)nav;


+ (UIViewController*)present:(NSString*)urlStr, ... ;
+ (UIViewController*)present:(NSString *)urlStr param:(NSDictionary*)param;

@end

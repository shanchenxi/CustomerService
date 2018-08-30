//
//  RouteTool.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/14.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "RouteTool.h"


#define ROOT [[[UIApplication sharedApplication]keyWindow]rootViewController]
#define ROOTLOG if (ROOT == nil) {NSLog(@"当前页无可用[[[UIApplication sharedApplication]keyWindow]rootViewController]");}
#define PROTOCOLLOG if (![vc respondsToSelector:@selector(setParam:)]) {NSLog(@"所使用的%@ 须实现<RouteToolParameter>协议！！",NSStringFromClass([vc class]));return nil;}

@interface NSArray (QueryItems)
/**query参数转字典*/
- (NSDictionary*)param;
@end
@implementation NSArray (RouteTool)
- (NSDictionary *)param{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
    for (NSURLQueryItem * item in self) {
        mutDic[item.name] = item.value;
    }
    return mutDic;
}
@end
@implementation UIViewController (RouteTool)
- (UIViewController*)push:(NSString *)urlStr, ...{
    va_list args;
    va_start(args, urlStr);

    return [RouteTool push:[[NSString alloc]initWithFormat:urlStr arguments:args]];
    //    [RouteTool push:urlStr nav:self.navigationController];

    va_end(args);

}
- (UIViewController*)pushWK:(NSString *)reqURLStr route:(NSString *)urlStr, ...{
    va_list args;
    va_start(args, urlStr);
    
    return [RouteTool push:[[NSString alloc]initWithFormat:urlStr arguments:args] param:@{@"url":reqURLStr}];
    //    [RouteTool push:urlStr nav:self.navigationController];
    
    va_end(args);
}
- (UIViewController*)present:(NSString *)urlStr, ...{
    
    va_list args;
    va_start(args, urlStr);
    
    return [RouteTool present:[[NSString alloc]initWithFormat:urlStr arguments:args]];
    
    va_end(args);
}
- (UIViewController*)pop{
   return [self.navigationController popViewControllerAnimated:YES];
}
- (void)dismiss{
   return  [self dismissViewControllerAnimated:YES completion:^{
        //TODO:可添加一个通知

    }];
}
@end
@implementation RouteTool
+ (UIViewController*)push:(NSString *)urlStr, ...{
    va_list args;
    va_start(args, urlStr);
    
    return [self push:[[NSString alloc]initWithFormat:urlStr arguments:args] nav:nil];
    
    va_end(args);
}
+ (UIViewController*)push:(NSString *)urlStr param:(NSDictionary*)param{
    return [self push:urlStr param:param nav:nil];
}
+ (UIViewController*)push:(NSString *)urlStr nav:(UINavigationController *)nav{
    return [self push:urlStr param:nil nav:nav];
}
+ (UIViewController*)push:(NSString *)urlStr param:(NSDictionary*)param nav:(UINavigationController *)nav{
    NSString * encodingString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSURLComponents *urlComp = [NSURLComponents componentsWithString:encodingString];
    UIViewController<RouteToolParameter> *vc = [[NSClassFromString(urlComp.URL.lastPathComponent) alloc]init];
    
    PROTOCOLLOG
    if (param.count > 0) {
        vc.param = param;
    }else{
        vc.param = urlComp.queryItems.param;
    }
    if (!nav) {
        nav = self.currentUINavigationController;
    }

    [nav pushViewController:vc animated:urlComp.fragment?urlComp.fragment.boolValue:YES];
    
    return vc;
    
}

+ (UIViewController*)present:(NSString *)urlStr, ...{
    va_list args;
    va_start(args, urlStr);
    
   return [self present:[[NSString alloc]initWithFormat:urlStr arguments:args] param:nil];
    
    va_end(args);

}
+ (UIViewController*)present:(NSString *)urlStr param:(NSDictionary*)param{
    NSString * encodingString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSURLComponents *urlComp = [NSURLComponents componentsWithString:encodingString];
    UIViewController<RouteToolParameter> *vc = [[NSClassFromString(urlComp.URL.lastPathComponent) alloc]init];
    
    PROTOCOLLOG
    if (param.count > 0) {
        vc.param = param;
    }else{
        vc.param = urlComp.queryItems.param;
    }
    ROOTLOG
    [ROOT presentViewController:vc animated:urlComp.fragment?urlComp.fragment.boolValue:YES completion:^{
        //TODO:可添加一个通知
    }];
    return vc;
}
+ (UINavigationController*)currentUINavigationController{
    ROOTLOG
    UINavigationController*nav = [self foundNavForVC:ROOT];
    if (nav == nil) {
        NSLog(@"当前页无可用UINavigationController");
    }
    return nav;
}
+ (UINavigationController*)foundNavForVC:(UIViewController *)vc{
    
    UINavigationController * nav = (UINavigationController*)vc;
    if ([vc isKindOfClass:[UINavigationController class]] && nav.visibleViewController.isViewLoaded && nav.visibleViewController.view.window) {
        nav = (UINavigationController*)vc;
        
    }else{
        for (id child in vc.childViewControllers) {
          nav = [self foundNavForVC:child];
            if ([nav isKindOfClass:[UINavigationController class]]) {
                break;
            }
        }
        
    }
    if ([nav isKindOfClass:[UINavigationController class]]) {
        return nav;
    }
    return nil;
}
@end

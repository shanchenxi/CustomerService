//
//  AppDelegate.m
//  CustomerService
//
//  Created by 吴宏佳 on 2018/8/27.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "AppDelegate.h"
#import "XGPush.h"
#import <BmobSDK/Bmob.h>

@interface XGPushDelegate : NSObject<XGPushDelegate>

@end

@implementation XGPushDelegate
#ifdef __IOS_AVAILABLE(10.0)
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center
      didReceiveNotificationResponse:(UNNotificationResponse *)response
               withCompletionHandler:(void(^)(void))completionHandler {
    [[XGPush defaultManager]
     reportXGNotificationInfo:response.notification.request.content.userInfo
     ];
    completionHandler();
}
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center
             willPresentNotification:(UNNotification *)notification
               withCompletionHandler:(void (^)
                                      (UNNotificationPresentationOptions))completionHandler {
    [[XGPush defaultManager]
     reportXGNotificationInfo:notification.request.content.userInfo];
    completionHandler(UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionSound |
                      UNNotificationPresentationOptionAlert);
}
#endif

@end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
//    [[XGPush defaultManager] startXGWithAppID:2200262432 appKey:@"I89WTUY132GJ"
//                                     delegate:[[XGPushDelegate alloc]init]];
    //BMOB
    [Bmob registerWithAppKey:@"781b49b3232cb155d1bbfa0e500be14e"];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
}


@end

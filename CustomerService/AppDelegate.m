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
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
@interface XGPushDelegate : NSObject<XGPushDelegate>

@end

@implementation XGPushDelegate
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"[XGDemo] click notification");
    if ([response.actionIdentifier isEqualToString:@"xgaction001"]) {
        NSLog(@"click from Action1");
    } else if ([response.actionIdentifier isEqualToString:@"xgaction002"]) {
        NSLog(@"click from Action2");
    }
    
    [[XGPush defaultManager] reportXGNotificationResponse:response];
    
    completionHandler();
}

// App 在前台弹通知需要调用这个接口
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
#endif

/**
 @brief 监控信鸽推送服务地启动情况
 
 @param isSuccess 信鸽推送是否启动成功
 @param error 信鸽推送启动错误的信息
 */
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(nullable NSError *)error{
    
}

/**
 @brief 向信鸽服务器注册设备token的回调
 
 @param deviceToken 当前设备的token
 @param error 错误信息
 @note 当前的token已经注册过之后，将不会再调用此方法
 */
- (void)xgPushDidRegisteredDeviceToken:(nullable NSString *)deviceToken error:(nullable NSError *)error{
    NSLog(@"--%@",deviceToken);

}
@end

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[XGPush defaultManager] startXGWithAppID:2200310128 appKey:@"IU39J35CU5PU" delegate:[[XGPushDelegate alloc]init]];

    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    [[XGPush defaultManager] setEnableDebug:YES];

    //BMOB
    [Bmob registerWithAppKey:@"781b49b3232cb155d1bbfa0e500be14e"];
    
    
    NSLog(@"%@",[[XGPush defaultManager]sdkVersion]);

    return YES;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"%@",[[NSString alloc]initWithData:deviceToken encoding:NSUTF8StringEncoding]);
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"[XGDemo] receive slient Notification");
    NSLog(@"[XGDemo] userinfo %@", userInfo);
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"[XGDemo] register APNS fail.\n[XGDemo] reason : %@", error);

}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    [Bmob activateSDK];
}

@end

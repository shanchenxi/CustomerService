//
//  SelectMainWindowTool.m
//  YiXiXinCourier
//
//  Created by mac on 17/1/12.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import "SelectWindowTool.h"
#import "AccountTool.h"
#import <CoreLocation/CoreLocation.h>
#import "OftenUse.h"
#import "HJButton.h"
#import "SetTool.h"
#import "AccountTool.h"
@implementation UIViewController (RouteTool)
- (void)presentLogin{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    [self presentViewController:[storyboard instantiateInitialViewController] animated:YES completion:nil];
}

@end

@implementation SelectWindowTool

+ (void)initialize{
    
    // UITabBarItem
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:MassToneAttune} forState:UIControlStateSelected];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:HJCOLOR6} forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:12.f]} forState:UIControlStateNormal];
//
//    //pageControl
//    [UIPageControl appearance].currentPageIndicatorTintColor = MassToneAttune;
//    ///UINavigationBar
//    [UINavigationBar appearance].barTintColor = MassToneAttune;
//    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
//    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//
    
    //UIviewcontroller加载前设置外观主题
    [UINavigationBar appearance].barTintColor = MassTone;
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};

    [HJButton appearance].backgroundColor = MassTone;
    
    [UIProgressView appearance].progressTintColor = [UIColor blueColor];

}
/**
 *  选择根控制器
 */
+ (void)chooseRootController{
    NSString *key = @"CFBundleVersion";
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        
        if (SetTool.havingALook || AccountTool.account) {
            [self toMain];

        }else{
            [self toLogin];

        }
        
    } else { // 新版本 New features

//        ///去引导页
        [self toNewFeatures];
//        // 存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
    
}
+(void)toAdvertising{//广告
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Advertising" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = [storyboard instantiateInitialViewController];

}

+(void)toLogin{//登录

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = [storyboard instantiateInitialViewController];
    
}
+ (void)presentLogin{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[storyboard instantiateInitialViewController] animated:YES completion:nil];
}
+(void)toMain{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ConsumersMain" bundle:nil];
    UITabBarController *tabbarC = [storyboard instantiateInitialViewController];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarC;
    if (SetTool.currentRole == RoleWorker) {
       UIViewController *lastVC = tabbarC.childViewControllers.lastObject;
        [lastVC removeFromParentViewController];
        UIViewController *neVC = [UIStoryboard storyboardWithName:@"WorkerMain" bundle:nil].instantiateInitialViewController;
        [tabbarC addChildViewController:neVC];
        neVC.tabBarItem.title = @"我的";
        neVC.tabBarItem.image = [UIImage imageNamed:@"me1_29"];
        
    }
    //检查更新
//    [SelectWindowTool isUpdate];
    
    
    if(![CLLocationManager locationServicesEnabled] || ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied))//判断定位服务是否打开
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位服务" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }
}

+(void)toNewFeatures{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NewFeatures" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = [storyboard instantiateInitialViewController];
    
}
+(void)isUpdate{
    ///TODO:添加appid
    NSURLSession *urlSession =  [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    NSURLSessionDataTask *dataTask =  [urlSession dataTaskWithURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/lookup?id=1232500797"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)  return ;
        
        NSString *jsonStr =   [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSRange leftRange = [jsonStr rangeOfString:@"version"];
        NSUInteger loc = leftRange.location+leftRange.length + 3;
        if (jsonStr.length < loc) return ;
        jsonStr = [jsonStr substringFromIndex:loc];
        NSRange rightRange = [jsonStr rangeOfString:@","];
        if (jsonStr.length < rightRange.location-1) return ;
        NSString *currentVersion = [jsonStr substringToIndex:rightRange.location-1];
        
        NSString *lastVersion =[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
        
        BOOL loob =  [currentVersion compare:lastVersion options:NSNumericSearch] ==NSOrderedDescending;
        
        if (loob) {
            dispatch_async(dispatch_get_main_queue(), ^{///回主线程执行UI部分
                NSString *key = @"CFBundleShortVersionString";//与App Store一致的版本号
                // 获得当前软件的版本号
                NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
                NSString *message = [ NSString stringWithFormat:@"有新版本啦~赶快去升级吧~\n当前版本：%@",currentVersion];

                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"升级！" message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAction =[UIAlertAction actionWithTitle:@"去升级！" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    ///TODO:添加升级链接
//                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E9%A1%B6%E6%9C%89%E9%B8%A3/id1232500797?mt=8"]];
                    //                NSURL *url  = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1232500797"];

                } ];
                [alert addAction:sureAction];
                
                [[[[UIApplication sharedApplication]keyWindow]rootViewController] presentViewController:alert animated:YES completion:nil];
                
            });
            
        }
    }];
    
    [dataTask resume];
    
}
@end

//
//  SelectMainWindowTool.h
//  YiXiXinCourier
//
//  Created by mac on 17/1/12.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIViewController (RouteTool)
- (void)presentLogin;

@end
@interface SelectWindowTool : NSObject
+ (void)chooseRootController;
+ (void)toLogin;
+ (void)presentLogin;
+ (void)toMain;
+ (void)toNewFeatures;
+ (void)isUpdate;
//广告
+ (void)toAdvertising;

@end

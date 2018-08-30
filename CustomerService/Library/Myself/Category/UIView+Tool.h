//
//  UIView+HUD.h
//  YiXiXinCourier
//
//  Created by mac on 17/1/13.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import <UIKit/UIKit.h>

#define keyWindow(text,time) [[[UIApplication sharedApplication]keyWindow] showHUDWithText:text hideDelay:time]
@interface UIView (HUD)
///延时展示文本
-(void)showHUDWithTip:(NSString*)tip;
///加载等待显示
-(void)showHUD;
///带文字等待显示
-(void)showHUDWithText:(NSString*)text;
///加载等待隐藏
-(void)hiddenHUD;
@end


@interface UIView (Dotted)
-(void)dottedLine;


@end

//
//  OftenUse.h
//  YiXiXinCourier
//
//  Created by mac on 17/1/12.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const forgotPassword;
UIKIT_EXTERN NSString *const registered ;

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define KeyWindow [[UIApplication sharedApplication]keyWindow]

///主色调
#define  MassTone [UIColor colorWithRed:34.f/255.f green:114.f/255.f blue:1.f alpha:1.f]

#define HJRGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:(a)]
#define HJCOLOR(r,g,b)  [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define HJCOLOR3 HJCOLOR(51.f, 51.f, 51.f)
#define HJCOLOR6 HJCOLOR(102.f, 102.f, 102.f)
#define HJCOLOR9 HJCOLOR(153.f, 153.f, 153.f)


///token 验证出错
#define LOGIN_TOKEN_ERROR  resultObj.err_code == 1001 || resultObj.err_code == 1002

///拼接主路径
#define MainURLString(url)  [NSString stringWithFormat:@"%@%@",[HttpClient defaultClient].baseURL,url]
#define MainURL(url)  [NSURL URLWithString:MainURLString(url)]

///判断系统版本
//9.0与9.0之后
#define iOS_9_After [[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] !=NSOrderedAscending
//8.4
#define iOS_8_4 [[[UIDevice currentDevice] systemVersion] compare:@"8.4" options:NSNumericSearch] ==NSOrderedSame


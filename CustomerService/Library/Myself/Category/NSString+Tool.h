//
//  NSString+Tool.h
//  YiXiXinCourier
//
//  Created by mac on 17/1/13.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JUDGE(string)  [NSString judgeString:string]

@interface NSString (Tool)
#pragma mark - 对象方法
///32位MD5加密
-(NSString *)MD5;
/// 是否是整数
-(BOOL)isInteger;
///是否是小数点后两位
-(BOOL)isTwoDecimalPlaces;
///string 转 字典
- (NSDictionary *)parseJSONString;
///中文转拼音
- (NSString*)chineseChangePinyin;
///字符串转时间
- (NSString *)timeMsg;
- (NSDate *)dateAll;
- (NSDate *)dateHm;
///字符串16进制色值转UIColor
-(UIColor *)color16;
///给11位电话号码加**
-(NSString*)phoneCover;
///随机字符串
- (NSString*)randomStr;
///随机文件名
- (NSString*)randomSuffix:(NSString*)suffix;
///岁
- (NSString*)age;
///年
- (NSString*)year;

#pragma mark - 工厂方法
///判断字符串是否为空
+(NSString*)judgeString:(NSString*)string;

@end

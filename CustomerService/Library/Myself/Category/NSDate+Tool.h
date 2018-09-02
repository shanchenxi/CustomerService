//
//  NSDate+Tool.h
//  DingYouMing
//
//  Created by ceyu on 2017/7/11.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import <Foundation/Foundation.h>

#define isNSDate(date)  [date isKindOfClass:[NSDate class]]
typedef NS_ENUM(NSInteger, HJComparisonResult) {HJBefore = -1L, HJInSperiod, HJAfter};

@interface NSDate (Tool)
///date是否在某段时间之内（小时之间判断）
-(HJComparisonResult)isInACertainTimePeriod:(NSDate*)start withStop:(NSDate*)stop;
///date是否 从今天起（不含今天）一个月之内
-(BOOL)isTodayInAMonth;
///获取次日开始时间
-(NSDate*)tomorrowStar;
///获取当日开始时间
-(NSDate*)today;
///Date 格式化成字符串
- (NSString *)stringHM;
- (NSString *)stringYMD_HM;
- (NSString *)stringYMD_HMS;
///判断是不是今天
-(BOOL)isToday;
///判断是不是明天
-(BOOL)isTomorrow;
@end

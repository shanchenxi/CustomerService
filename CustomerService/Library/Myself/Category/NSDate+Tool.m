//
//  NSDate+Tool.m
//  DingYouMing
//
//  Created by ceyu on 2017/7/11.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import "NSDate+Tool.h"

@implementation NSDate (Tool)
-(HJComparisonResult)isInACertainTimePeriod:(NSDate*)start withStop:(NSDate*)stop{
    if (!start || !stop) {
        return NO;
    }
    NSCalendar*calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSCalendarUnit unitFlags =NSCalendarUnitHour|NSCalendarUnitMinute;
    
    
    NSDateComponents*compCurrent = [calendar components:unitFlags fromDate:self];//获取不同时间
    NSDateComponents*compStart = [calendar components:unitFlags fromDate:start];//获取不同时间
    NSDateComponents*compStop = [calendar components:unitFlags fromDate:stop];//获取不同时间
    BOOL startAfter = compCurrent.hour > compStart.hour || (compCurrent.minute > compStart.minute && compCurrent.hour == compStart.hour);
    BOOL stopBefore = compCurrent.hour < compStop.hour || (compCurrent.minute < compStop.minute && compCurrent.hour == compStop.hour);
    
    if (startAfter && stopBefore) {
        return HJInSperiod;
    }else if (!startAfter){
        return HJBefore;
    }else{
        return HJAfter;
    }

}
-(NSDate*)today{
    NSCalendar*calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSCalendarUnit unitFlags =NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents*compTomorrow = [calendar components:unitFlags fromDate:[NSDate date]];//获取不同时间
    
    unitFlags =NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents*compStar = [calendar components:unitFlags fromDate:self];//获取不同时间
    
    compTomorrow.hour = compStar.hour;
    compTomorrow.minute =  compStar.minute +1;
    return [calendar dateFromComponents:compTomorrow];
}
-(NSDate*)tomorrowStar{
    return  [[self today] dateByAddingTimeInterval:60 * 60 * 24];
}
-(BOOL)isTodayInAMonth{
    NSDate *today  = [NSDate date];
    NSDate *at30Days = [today dateByAddingTimeInterval:60 * 60 * 24 * 30];
    
    return [self compare:today] == NSOrderedDescending && [self compare:at30Days] != NSOrderedDescending;
}




- (NSString *)stringHM{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    return  [df stringFromDate:self];
}
- (NSString *)stringYMD_HM{

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    return  [df stringFromDate:self];
}
- (NSString *)stringYMD_HMS{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return  [df stringFromDate:self];
}
-(BOOL)isToday{
    NSCalendar*calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSCalendarUnit unitFlags =NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents*compToday = [calendar components:unitFlags fromDate:[NSDate date]];//获取不同时间
    NSDateComponents*compOther = [calendar components:unitFlags fromDate:self];//获取不同时间
    return compToday.day == compOther.day && compToday.year == compOther.year && compToday.month == compOther.month;
}
-(BOOL)isTomorrow{
    NSCalendar*calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSCalendarUnit unitFlags =NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents*compToday = [calendar components:unitFlags fromDate:[NSDate date]];//获取不同时间
    NSDateComponents*compOther = [calendar components:unitFlags fromDate:self];//获取不同时间

    return compToday.day+1 == compOther.day && compToday.year == compOther.year && compToday.month == compOther.month;
}
@end

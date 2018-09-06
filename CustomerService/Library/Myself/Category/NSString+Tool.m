//
//  NSString+Tool.m
//  YiXiXinCourier
//
//  Created by mac on 17/1/13.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import "NSString+Tool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Tool)
#pragma mark - 对象方法

#pragma mark md5加密32位
-(NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
#pragma mark 是否是整数
-(BOOL)isInteger{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
    
}
#pragma mark 是否是小数点后两位
-(BOOL)isTwoDecimalPlaces{
    float number = self.floatValue;
    NSRange range = [self rangeOfString:@"."];
    NSScanner * scanner = [NSScanner scannerWithString:self];
    
    return (range.length == 0 || range.location == self.length - 3|| range.location == self.length - 2)&&self.length > 0 && number > 0 &&[scanner scanFloat:&number] && [scanner isAtEnd];
    
}
//-(void)
//NSError *parseError = nil;
//NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
//return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//}
#pragma mark string 转 字典
- (NSDictionary *)parseJSONString{
    
    NSData *JSONData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
    
}
-(NSString*)chineseChangePinyin{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    return [str capitalizedString];
}

-(NSString *)timeMsg{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if ([NSString judgeString:self].length == 0) {//如果字符串为空  则返回当前时间
        return @"";
    }
    NSDate *date = [df dateFromString: [NSString judgeString:self]];
    CGFloat second = [date  timeIntervalSince1970];
    CGFloat cha = [[NSDate date]  timeIntervalSince1970] - second;
    if (cha < 60) {
        return  @"刚刚";
    }
    if (cha > 60 && cha < 60*60*24) {
        [df setDateFormat:@"HH:mm"];
        
        return  [df stringFromDate:date];
    }
    if (cha > 60*60*24 && cha < 60*60*24*365) {
        [df setDateFormat:@"MM-dd HH:mm"];
        
        return  [df stringFromDate:date];
    }
    if (cha > 60*60*24*365) {
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        return  [df stringFromDate:date];
    }
    
    return nil;
}
-(NSDate *)dateAll{
  
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    if ([NSString judgeString:self].length == 0) {//如果字符串为空  则返回当前时间
        return [NSDate date];
    }
    return [df dateFromString: [NSString judgeString:self]];
}
-(NSDate *)dateHm{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"HH:mm"];
    if ([NSString judgeString:self].length == 0) {//如果字符串为空  则返回当前时间
        return [NSDate date];
    }
    return [df dateFromString:[NSString judgeString:self] ];
}
#pragma mark - UIColor
-(UIColor *)color16{
    NSString* valueStr = self;
    if (valueStr.length != 6) {
        return [UIColor blackColor];
    }
    unsigned long rgbValue = strtoul([valueStr UTF8String],0,16);
    
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
    
}
- (NSString *)phoneCover{
    if (self.length == 11) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(3, 6) withString:@"******"];
    }else{
        return self;
    }
}
- (NSString*)randomStr{
    NSInteger sec = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld%u",sec,arc4random()%10000];
}
- (NSString*)randomSuffix:(NSString*)suffix{
    
    return [self stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",[self randomStr],suffix]];
}
- (NSString*)age{
    return [NSString stringWithFormat:@"%@岁",self];
}
- (NSString*)year{
    return [NSString stringWithFormat:@"%@年",self];
}

#pragma mark - 工厂方法

#pragma mark  对字符串的值进行判断
+(NSString*)judgeString:(NSString*)string
{
    NSString * currentStr = [NSString stringWithFormat:@"%@",string];
    if (string &&currentStr.length && [string isKindOfClass:[NSString class]] && ![string isKindOfClass:[NSNull class]] &&  ![currentStr isEqualToString:@"(null)"] && ![currentStr isEqualToString:@"<null>"]) {
        return string;
    }
    return @"";
}


@end

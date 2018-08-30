//
//  NSNumber+Tool.m
//  DingYouMing
//
//  Created by ceyu on 2017/3/3.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import "NSNumber+Tool.h"

@implementation NSNumber (Tool)
+(NSNumber *)pageForTotal:(NSInteger)total{
    return [self pageForTotal:total withLines:20];
}
+(NSNumber *)pageForTotal:(NSInteger)total withLines:(NSInteger)lines{
    NSInteger page = total/lines + 1;
    if (total%lines != 0)   page += 1;
    return @(page);
}
- (NSString *)sex{
    return self.intValue == 1 ?@"女":@"男";
}
@end

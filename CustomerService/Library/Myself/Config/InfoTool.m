//
//  InfoTool.m
//  Gorgeous
//
//  Created by lyt on 2018/5/22.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "InfoTool.h"

@implementation InfoTool

+ (NSString*)AlipaySchemes{
    return [self URLSchemes:@"alipay"];
}
+ (NSString*)WXSchemes{
    return [self URLSchemes:@"weixin"];
}
+ (NSString*)QQAppID{
    NSMutableString *str = [NSMutableString stringWithString:[self URLSchemes:@"tencent"]];
    [str deleteCharactersInRange:NSMakeRange(0, 7)];
    return str;
}
+ (NSString*)QQSchemes{
    return [self URLSchemes:@"tencent"];
}
+ (NSString*)URLSchemes:(NSString*)name{
    NSArray *arr = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    NSString *str = nil;
    for (NSDictionary* dic in arr) {
        if ([dic[@"CFBundleURLName"] isEqualToString:name]) {
            str = [dic[@"CFBundleURLSchemes"] firstObject];
            break;
        }
    }
    return str;

}
@end

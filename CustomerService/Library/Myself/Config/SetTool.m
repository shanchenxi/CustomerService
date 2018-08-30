//
//  SetTool.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/14.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "SetTool.h"

#define SET [NSUserDefaults standardUserDefaults]

NSString* const CurrentRoleKey = @"CurrentRoleKey";
NSString* const HavingALookKey = @"HavingALookKey";
NSString* const UserPhone = @"UserPhone";
static NSString* UserCity = @"UserCity";


@implementation SetTool
+ (SetToolRole)currentRole{
    return [SET integerForKey:CurrentRoleKey];
}
+ (void)setCurrentRole:(SetToolRole)currentRole{
    [SET setInteger:currentRole forKey:CurrentRoleKey];
}


+ (BOOL)havingALook{
    return [SET boolForKey:HavingALookKey];
}
+ (void)setHavingALook:(BOOL)havingALook{
    [SET setBool:havingALook forKey:HavingALookKey];
}

+ (NSString *)phone{
    return [SET stringForKey:UserPhone];
}
+ (void)setPhone:(NSString *)phone{
    [SET setObject:phone forKey:UserPhone];
}

+ (NSString *)city{
    return UserCity;
}
+ (void)setCity:(NSString *)city{
    UserCity = city;
}
@end

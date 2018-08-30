//
//  SetTool.h
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/14.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SetToolRole) {
    RoleConsumers = 1,
    RoleWorker
};
@interface SetTool : NSObject
///当前用户选择的角色 1： 工人  0： 消费者
+ (SetToolRole)currentRole;
+ (void)setCurrentRole:(SetToolRole)currentRole;
///是否点击了随便看看 
+ (BOOL)havingALook;
+ (void)setHavingALook:(BOOL)havingALook;

///手机号  如果是微信登录 则值为 wechat  如果是QQ登录  则值为 qq
+ (NSString*)phone;
+ (void)setPhone:(NSString*)phone;

///当前定位城市
+ (NSString*)city;
+ (void)setCity:(NSString*)city;
@end

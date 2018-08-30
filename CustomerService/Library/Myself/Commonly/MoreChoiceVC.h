//
//  MoreChoiceVC.h
//  mx
//
//  Created by lyt on 2018/4/12.
//  Copyright © 2018年 chinasns. All rights reserved.
//

#import "HJViewController.h"

#define MoreChoiceAdd(imgName,title,key) [objs addObject:[MoreChoiceObj createImgName:imgName withTitle:title withKey:key]]

@interface MoreChoiceObj : NSObject
@property (strong, nonatomic) NSString *imgName;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *key;
+ (instancetype)createImgName:(NSString*)imgName withTitle:(NSString*)title withKey:(NSString*)key;

@end

@interface MoreChoiceVC : HJViewController
+ (void)addObj:(void (^)(NSMutableArray * objs))block completion:(void (^)(NSString *key))completion;
@end

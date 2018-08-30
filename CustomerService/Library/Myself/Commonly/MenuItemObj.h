//
//  MenuItemObj.h
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/22.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MenuItemAdd(title,imgName) [objs addObject:[MenuItemObj createImgName:imgName withTitle:title]]

@interface MenuItemObj : NSObject

@property (strong, nonatomic) NSString *imgName;

@property (strong, nonatomic) NSString *title;

+ (instancetype)createImgName:(NSString*)imgName withTitle:(NSString*)title;

+ (NSMutableArray*)makeObjs:(void(^)(NSMutableArray* objs))block;

@end

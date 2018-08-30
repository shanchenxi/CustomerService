//
//  MenuItemObj.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/22.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "MenuItemObj.h"

@implementation MenuItemObj
+ (instancetype)createImgName:(NSString *)imgName withTitle:(NSString *)title{
    MenuItemObj *obj = [[MenuItemObj alloc]init];
    obj.title = title;
    obj.imgName = imgName;
    
    return obj;
}

+ (NSMutableArray*)makeObjs:(void(^)(NSMutableArray* objs))block{
    NSMutableArray *objs = [NSMutableArray array];
    if (block) {
        block(objs);
    }
    return objs;
}

@end



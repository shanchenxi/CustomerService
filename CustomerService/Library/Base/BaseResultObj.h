//
//  BaseResultObj.h
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/25.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResultObj : NSObject
@property (assign, nonatomic) NSInteger status;
@property (strong, nonatomic) id data;
@property (strong, nonatomic) NSArray* typelist;

@end

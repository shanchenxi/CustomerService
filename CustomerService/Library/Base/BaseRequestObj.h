//
//  BaseRequestObj.h
//  Gorgeous
//
//  Created by lyt on 2018/4/26.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequestObj : NSObject

+ (instancetype)reqObj;
@end

@interface PageRequestObj : BaseRequestObj
@property (strong, nonatomic) NSNumber *page;

@end

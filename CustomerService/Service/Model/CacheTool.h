//
//  CacheTool.h
//  CustomerService
//
//  Created by 吴宏佳 on 2018/9/6.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MsgObj.h"

@interface CacheTool : NSObject
+(void)addBMKPoiInfo:(MsgObj *)poiInfo;
+(void)deleteBMKPoiInfo;
+ (NSMutableArray<MsgObj*> *)obtainBMKPoiInfos;
+ (MsgObj *)obtainBMKPoiInfosLast;

@end

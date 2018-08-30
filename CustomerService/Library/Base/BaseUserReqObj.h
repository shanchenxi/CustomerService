//
//  BaseUserReqObj.h
//  Gorgeous
//
//  Created by lyt on 2018/4/26.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "BaseRequestObj.h"

@interface BaseUserReqObj : BaseRequestObj
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *uid;

@end

@interface PageUserReqObj : BaseUserReqObj
@property (strong, nonatomic) NSNumber *page;

@end


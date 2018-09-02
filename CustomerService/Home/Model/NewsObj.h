//
//  NewsObj.h
//  CustomerService
//
//  Created by 吴宏佳 on 2018/9/2.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsObj : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *imgs;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *updatedAt;

@end

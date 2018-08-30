//
//  HJTableViewController.h
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/14.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteTool.h"

@interface HJTableViewController : UITableViewController<RouteToolParameter>

+ (instancetype)create;


@end

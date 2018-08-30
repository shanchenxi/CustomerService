//
//  BidBarMenuView.h
//  mx
//
//  Created by lyt on 2017/11/30.
//  Copyright © 2017年 chinasns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarMenuView : UIView

@property (strong, nonatomic) NSArray *titles;
+ (instancetype)addObj:(void (^)(NSMutableArray * objs))block completion:(void (^)(NSInteger index,NSString* title))completion viewDidDisappear:(void (^)(void))completion;

@end

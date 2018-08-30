//
//  HJButton.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/15.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "HJButton.h"

@implementation HJButton
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//
//
//    }
//    return self;
//}
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//
//
//
//    }
//    return self;
//}
//- (CGRect)backgroundRectForBounds:(CGRect)bounds{
//    self.layer.cornerRadius = 5.f;
//    return [super backgroundRectForBounds:bounds];
//}
//- (CGRect)contentRectForBounds:(CGRect)bounds{
//    return [super contentRectForBounds:bounds];
//}
//- (CGRect)titleRectForContentRect:(CGRect)contentRect{
//    return [super titleRectForContentRect:contentRect];
//}
//- (CGRect)imageRectForContentRect:(CGRect)contentRect{
//    return [super imageRectForContentRect:contentRect];
//}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.layer.cornerRadius == 0 && !self.isCornerRadius) {
        self.layer.cornerRadius = 3.f;
    }
}
@end

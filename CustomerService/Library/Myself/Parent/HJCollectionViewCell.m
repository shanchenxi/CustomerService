//
//  HJCollectionViewCell.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/22.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "HJCollectionViewCell.h"

@implementation HJCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSet];

    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self defaultSet];

}
- (void)defaultSet{

}
@end

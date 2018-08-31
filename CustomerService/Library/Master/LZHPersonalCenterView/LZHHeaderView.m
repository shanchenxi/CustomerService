//
//  LZHHeaderView.m
//  LZH_PersonalCenter
//
//  Created by admin  on 2018/7/21.
//  Copyright © 2018年 刘中华. All rights reserved.
//

#import "LZHHeaderView.h"

@implementation LZHHeaderView

+(instancetype)intHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject
            ];
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

@end

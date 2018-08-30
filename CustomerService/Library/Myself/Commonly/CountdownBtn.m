//
//  CountdownBtn.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/21.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "CountdownBtn.h"

#define CountdownBtnTag  16546

@interface CountdownBtn ()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CountdownBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    [self addTarget:self action:@selector(countdownBeginAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)countdownBeginAction:(UIButton *)btn {
    if (btn.enabled) {
        return;
    }
    btn.enabled = NO;
    btn.tag = CountdownBtnTag + 120;
    [btn setTitle:@(120).stringValue forState:UIControlStateNormal];

    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdownAction:) userInfo:btn repeats:YES];
}
- (void)countdownAction:(NSTimer*)timer{
    UIButton* btn = timer.userInfo;
    btn.tag--;
    [btn setTitle:@(btn.tag - CountdownBtnTag).stringValue forState:UIControlStateNormal];
    
    if (btn.tag == CountdownBtnTag) {
        [timer invalidate];
        timer = nil;
        btn.enabled = YES;
        btn.tag = CountdownBtnTag + 120;
        [btn setTitle:@"获取" forState:UIControlStateNormal];
    }
}
- (void)removeFromSuperview{
    [super removeFromSuperview];
    [self.timer invalidate];
}

- (void)dealloc{
    self.timer = nil;

}
@end

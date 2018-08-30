//
//  UIView+HUD.m
//  YiXiXinCourier
//
//  Created by mac on 17/1/13.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import "UIView+Tool.h"
#import "MBProgressHUD.h"

@implementation UIView (HUD)
-(void)showHUDWithTip:(NSString*)tip{
    if (!tip) return;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = tip;
    [hud hideAnimated:YES afterDelay:1.5];
}
-(void)showHUD{
    [self showHUDWithText:nil];
}
-(void)showHUDWithText:(NSString*)text{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = text?MBProgressHUDModeCustomView:MBProgressHUDModeIndeterminate;
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:60.0];//60s无响应就隐藏

}
-(void)hiddenHUD{
    [MBProgressHUD hideHUDForView:self animated:YES];
    
}

@end


@implementation UIView (Dotted)
-(void)dottedLine{
    CAShapeLayer *dotted = [CAShapeLayer layer];
    
    dotted.strokeColor = [UIColor colorWithRed:157.f/255.f green:157.f/255.f blue:157.f/255.f alpha:1.f].CGColor;
    
    dotted.fillColor = nil;
    
    dotted.path = [self lineBezier];
    
    dotted.frame = self.bounds;
    
    dotted.lineWidth = 1.f;
    
    dotted.lineCap = @"square";
    
    dotted.lineDashPattern = @[@4, @2];
    
    [self.layer addSublayer:dotted];
    
}
-(CGPathRef)lineBezier{
    UIBezierPath * bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointZero];
    [bezier addLineToPoint:CGPointMake([UIScreen mainScreen].bounds.size.width, 0)];
    return bezier.CGPath;
}

@end


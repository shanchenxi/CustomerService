//
//  dashBoardVC.m
//  CustomerService
//
//  Created by 单晨曦 on 2018/9/1.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//
#define RGB(r,g,b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


#import "dashBoardVC.h"
#import "FKDashBoardView.h"

@interface dashBoardVC ()

@property (weak, nonatomic) FKDashBoardView *dashBoard;


@end

@implementation dashBoardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(246, 245, 246);
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"信用分数";
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIColor *color = [UIColor colorWithWhite:1 alpha:0.2];
    FKDashBoardView *dashBoard = [[FKDashBoardView alloc] initWithStartAngle:160
                                                                    endAngle:380];
    dashBoard.frame = CGRectMake(30, 30, screenSize.width - 60, 260);
    
    dashBoard.titleLabel.text = @"371";
    dashBoard.titleLabel.font = [UIFont boldSystemFontOfSize:32];
    dashBoard.titleLabel.textColor = [UIColor whiteColor];
    
    dashBoard.subtitleLabel.text = @"信用分数";
    dashBoard.subtitleLabel.font = [UIFont systemFontOfSize:14];
    dashBoard.subtitleLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    
    [dashBoard setMargin:2];
    [dashBoard setPadding:2];
    [dashBoard setDashBoardWidth:15];
    
    [dashBoard setDashBoardBigScaleColor:[UIColor whiteColor]];
    [dashBoard setDashBoardSmallScaleColor:[UIColor colorWithWhite:1 alpha:0.6]];
    
    [dashBoard setDashBoardColor:color];
    [dashBoard setProgress:0.0];
    [self.view addSubview:dashBoard];
    self.dashBoard = dashBoard;
    
    // 0.1秒后获取frame
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.dashBoard setProgress:0.6];
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

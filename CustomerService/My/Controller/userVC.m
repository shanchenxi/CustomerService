//
//  userVC.m
//  CustomerService
//
//  Created by 单晨曦 on 2018/8/31.
//  Copyright © 2018年 单晨曦. All rights reserved.
//


#import "userVC.h"
#import "UIView+Tool.h"
#import "LZHPersonalCenterView.h"
#import "setIconVC.h"
#import "userSettingVC.h"

@interface userVC ()<LZHPersonalCenterViewDelegate>

@property (strong, nonatomic) NSArray *arr;

@end

@implementation userVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor lightGrayColor];

    
    
    NSArray * centerArr = @[@[@"保障",@"卡包"],@[@"保养",@"信用",@"天气"],@[@"设置"]] ;
    LZHPersonalCenterView * pcv = [[LZHPersonalCenterView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) CenterArr:centerArr isShowHeader:YES];
    pcv.delegate = self ;
    //按需求定是否需要
    pcv.extendCenterRightArr = @[@[@"",@"0"],@[@"暂不需要",@"100",@"晴"],@[@""]] ;
    [self.view addSubview:pcv];

}

-(void)didSelectRowTitle:(NSString *)title{
    NSLog(@"点击：---  %@",title) ;
    if ([title isEqual: @"设置"]) {
        userSettingVC *usersetVC = [[userSettingVC alloc] init];
        [self.navigationController pushViewController:usersetVC animated:YES];
    } else {
        [self.view showHUDWithTip:@"即将推出"];
    }
}

-(void)tapHeader{
    setIconVC *setiVC = [[setIconVC alloc] init];
    [self.navigationController pushViewController:setiVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

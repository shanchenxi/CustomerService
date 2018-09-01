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
#import "dashBoardVC.h"
#import "aboutUsVC.h"

@interface userVC ()<LZHPersonalCenterViewDelegate>

@property (strong, nonatomic) NSArray *arr;

@end

@implementation userVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor lightGrayColor];

    
    NSArray * centerArr = @[@[@"保障",@"卡包"],@[@"保养",@"信用",@"天气"],@[@"清除缓存",@"关于我们"]] ;
    LZHPersonalCenterView * pcv = [[LZHPersonalCenterView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) CenterArr:centerArr isShowHeader:NO];
    pcv.delegate = self ;
    //按需求定是否需要
    pcv.extendCenterRightArr = @[@[@"",@"0"],@[@"暂不需要",@"371",@""],@[@"",@""]] ;
    [self.view addSubview:pcv];

}

-(void)didSelectRowTitle:(NSString *)title{
    NSLog(@"点击：---  %@",title) ;
    if ([title isEqual: @"设置"]) {
        
    } else if ([title isEqual: @"信用"]){
        dashBoardVC *dabVC = [[dashBoardVC alloc] init];
        [self.navigationController pushViewController:dabVC animated:YES];
    }else if ([title isEqual: @"清除缓存"]){
        [self clearTmpPics];
    }else if ([title isEqual: @"关于我们"]){
        aboutUsVC *aboutVC = [[aboutUsVC alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }else {
        [self.view showHUDWithTip:@"即将推出"];
    }
}

-(void)tapHeader{

}
//清除缓存 sharedImageCache
- (void)clearTmpPics
{
    float tmpSize = [[SDImageCache sharedImageCache] getSize] / 1024 /1024;
    NSString *clearCacheSizeStr = tmpSize >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",tmpSize] : [NSString stringWithFormat:@"清理缓存(%.2fK)",tmpSize * 1024];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self.view showHUDWithTip:clearCacheSizeStr];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

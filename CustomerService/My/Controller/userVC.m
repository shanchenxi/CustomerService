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
#import "aboutUsVC.h"
#import "FeedbackVC.h"

@interface userVC ()<LZHPersonalCenterViewDelegate>

@property (strong, nonatomic) NSArray *arr;

@end

@implementation userVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = [UIColor lightGrayColor];

    
    NSArray * centerArr = @[@[@"更换主题",@"建议与留言",@"分享给朋友"],@[@"清除缓存",@"关于我们"]] ;
    LZHPersonalCenterView * pcv = [[LZHPersonalCenterView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) CenterArr:centerArr isShowHeader:NO];
    pcv.delegate = self ;
    //按需求定是否需要
    pcv.extendCenterRightArr = @[@[@"",@"",@""],@[@"",@""]];
    [self.view addSubview:pcv];

}

-(void)didSelectRowTitle:(NSString *)title{
    NSLog(@"点击：---  %@",title) ;
    if ([title isEqual: @"清除缓存"]){
        [self clearTmpPics];
    }else if ([title isEqual: @"关于我们"]){
        aboutUsVC *aboutVC = [[aboutUsVC alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }else if ([title isEqual: @"建议与留言"]){
        FeedbackVC *feedbackVC = [[FeedbackVC alloc] init];
        [self.navigationController pushViewController:feedbackVC animated:YES];
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

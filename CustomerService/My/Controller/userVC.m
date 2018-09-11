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
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    
//    NSArray * centerArr = @[@[@"更换主题",@"建议与留言",@"分享给朋友"],@[@"清除缓存",@"关于我们"]] ;
//    LZHPersonalCenterView * pcv = [[LZHPersonalCenterView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) CenterArr:centerArr isShowHeader:NO];
//    pcv.delegate = self ;
//    //按需求定是否需要
//    pcv.extendCenterRightArr = @[@[@"",@"",@""],@[@"",@""]];
//    [self.view addSubview:pcv];
    
    self.arr = @[@[@{@"img":@"更换主题",@"text":NSLocalizedString(@"ReplaceTopic", nil)},
                   @{@"img":@"建议与留言",@"text":NSLocalizedString(@"Suggestions", nil)},
                   @{@"img":@"分享给朋友",@"text":NSLocalizedString(@"Share", nil)}],
                @[@{@"img":@"清除缓存",@"text":NSLocalizedString(@"ClearCache", nil)},
                @{@"img":@"关于我们",@"text":NSLocalizedString(@"About", nil)},]];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arr[section] count];
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"741852"];
    NSDictionary *dic = self.arr[indexPath.section][indexPath.row];
    cell.textLabel.text = dic[@"text"];
    cell.imageView.image = [UIImage imageNamed:dic[@"img"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self didSelectRowTitle:self.arr[indexPath.section][indexPath.row][@"img"]];
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
        [self.view showHUDWithTip:NSLocalizedString(@"Comingsoon", nil)];
    }
}

-(void)tapHeader{

}
//清除缓存 sharedImageCache
- (void)clearTmpPics
{
    float tmpSize = [[SDImageCache sharedImageCache] getSize] / 1024 /1024;
    NSString *clearCacheSizeStr = tmpSize >= 1 ? [NSString stringWithFormat:@"%@(%.2fM)",NSLocalizedString(@"ClearCache", nil),tmpSize] : [NSString stringWithFormat:@"%@(%.2fK)",NSLocalizedString(@"ClearCache", nil),tmpSize * 1024];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self.view showHUDWithTip:clearCacheSizeStr];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

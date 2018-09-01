//
//  userSettingVC.m
//  CustomerService
//
//  Created by 单晨曦 on 2018/9/1.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#define RGB(r,g,b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define  viewWidth [UIScreen mainScreen].bounds.size.width
#define  viewHeight [UIScreen mainScreen].bounds.size.height

#import "userSettingVC.h"
#import "SDImageCache.h"
#import "UIView+Tool.h"
#import "aboutUsVC.h"

@interface userSettingVC ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation userSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = RGB(245, 245, 245);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"userSetting"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *arr = @[@"清楚缓存",@"关于我们"];
    cell.textLabel.text = arr[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self clearTmpPics];
    } else {
        aboutUsVC *aboutVC = [[aboutUsVC alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


//清除缓存 sharedImageCache
- (void)clearTmpPics
{
    float tmpSize = [[SDImageCache sharedImageCache] getSize] / 1024 /1024;
    NSString *clearCacheSizeStr = tmpSize >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",tmpSize] : [NSString stringWithFormat:@"清理缓存(%.2fK)",tmpSize * 1024];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self.tableView showHUDWithTip:clearCacheSizeStr];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

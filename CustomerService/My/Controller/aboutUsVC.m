//
//  aboutUsVC.m
//  CustomerService
//
//  Created by 单晨曦 on 2018/9/1.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//
//RGB
#define RGB(r,g,b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#import "aboutUsVC.h"
#import "Masonry.h"

@interface aboutUsVC ()
@property (nonatomic,strong) UIImageView *logoImg;
@property (nonatomic,strong) UILabel *versionLable;

@end

@implementation aboutUsVC

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"关于我们";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);

    self.logoImg = [[UIImageView alloc] init];
    self.logoImg.image = [UIImage imageNamed:@"account_tu1"];
    [self.view addSubview:self.logoImg];
    [_logoImg makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(78.f);
        make.centerX.equalTo(0.f);
        make.width.height.equalTo(80.f);
    }];
    
    self.versionLable = [[UILabel alloc] init];
    self.versionLable.textColor = RGB(179, 179, 179);
    self.versionLable.font = [UIFont systemFontOfSize:12];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    // 获取App的版本号
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    self.versionLable.text = appVersion;
    [self.view addSubview:self.versionLable];
    [_versionLable makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-26.f);
        make.centerX.equalTo(0.f);
        make.height.equalTo(12.f);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end

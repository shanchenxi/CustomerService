//
//  HJNavigationController.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/3/25.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "HJNavigationController.h"

@interface HJNavigationController ()

@end

@implementation HJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate{
    return NO;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        self.viewControllers.firstObject.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];

    }

    [super pushViewController:viewController animated:YES];
}

@end

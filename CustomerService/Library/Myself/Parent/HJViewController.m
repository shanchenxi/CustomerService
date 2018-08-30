//
//  HJViewController.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/3/25.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "HJViewController.h"

@interface HJViewController ()

@end

@implementation HJViewController
@synthesize param;

+ (instancetype)create{
    return [[self alloc]init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.title.length == 0) {
        self.title = self.param[@"title"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate{
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

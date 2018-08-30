//
//  HJTableViewController.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/14.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "HJTableViewController.h"

@interface HJTableViewController ()

@end

@implementation HJTableViewController
@synthesize param;
+ (instancetype)create{
    return [[self alloc]init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.title.length == 0) {
        self.title = self.param[@"title"];
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate{
    return NO;
}

@end

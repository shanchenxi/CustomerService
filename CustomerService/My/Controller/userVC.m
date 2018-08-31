//
//  userVC.m
//  CustomerService
//
//  Created by 单晨曦 on 2018/8/31.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#define  viewWidth [UIScreen mainScreen].bounds.size.width
#define  viewHeight [UIScreen mainScreen].bounds.size.height

#import "userVC.h"

@interface userVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation userVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ID_Cell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    //cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"头像", @"年龄", @"性别", @"设置", nil];
    cell.textLabel.text = arr[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

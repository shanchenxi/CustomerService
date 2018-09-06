//
//  ServiceTVC.m
//  CustomerService
//
//  Created by 吴宏佳 on 2018/8/31.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "ServiceTVC.h"
#import <BmobSDK/Bmob.h>
#import "CacheTool.h"



@interface ServiceTVC ()
@property (strong, nonatomic) NSString *lastText;

@end

@implementation ServiceTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;

//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
   
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.lastText = [CacheTool obtainBMKPoiInfosLast].text;
    [self.tableView reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString*)rondomStr:(NSInteger)len{
    NSString *base = @"的,控,件,阿,凡,达,看,风,景,阿,里,是,的,刚,开,始";
    NSArray*baseArr = [base componentsSeparatedByString:@","];
    NSMutableString *str = [NSMutableString string];
    for (NSInteger num =0; num <len ; num++) {
        [str  appendString:baseArr[arc4random()%baseArr.count]];
        
    }
    return str;
}
//- (NSMutableArray *)datas{
//    if (!_datas) {
//        _datas = [NSMutableArray array];
//    }
//    return _datas;
//}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellID = @"gasdgasdgweq";
    HJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID ];
    if (!cell) {
        cell = [[HJTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.imageView.image= [UIImage imageNamed:@"messagesys"];
    cell.textLabel.text = @"系统消息";
    cell.detailTextLabel.text = self.lastText.length==0?@"暂无更多消息，点击进入获取更多消息":self.lastText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self push:@"MsgVC?"];


}

@end

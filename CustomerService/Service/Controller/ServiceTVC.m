//
//  ServiceTVC.m
//  CustomerService
//
//  Created by 吴宏佳 on 2018/8/31.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "ServiceTVC.h"
#import <BmobSDK/Bmob.h>
#import "MsgObj.h"

static NSString *LeftCellID = @"ServiceLeftCell";
static NSString *RightCellID = @"ServiceRightCell";
@interface ServiceTVC ()
@property (strong, nonatomic) NSString *lastText;

@end

@implementation ServiceTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    
    
    
    
    //查找表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"ServiceMsg"];
    bquery.limit = 1;
    [bquery orderByDescending:@"updatedAt"];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (error){
            //进行错误处理
        }else{
            //表里有id为0c6db13c的数据
            if (array.firstObject) {
                //得到playerName和cheatMode
                self.lastText = [array.firstObject objectForKey:@"text"];
                [self.tableView reloadData];
            }
        }
    }];

   
    
    
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
    cell.imageView.image = [UIImage imageNamed:@"头像"];
    cell.textLabel.text = @"客服人员1";
    cell.detailTextLabel.text = self.lastText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self push:@"MsgVC?"];


}

@end

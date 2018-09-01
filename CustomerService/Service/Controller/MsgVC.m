//
//  MsgVC.m
//  CustomerService
//
//  Created by 吴宏佳 on 2018/9/1.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "MsgVC.h"

#import <BmobSDK/Bmob.h>
#import "MsgObj.h"

static NSString *LeftCellID = @"ServiceLeftCell";
static NSString *RightCellID = @"ServiceRightCell";

@interface MsgVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *msgTF;
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation MsgVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:LeftCellID bundle:nil] forCellReuseIdentifier:LeftCellID];
    [self.tableView registerNib:[UINib nibWithNibName:RightCellID bundle:nil] forCellReuseIdentifier:RightCellID];
    for (NSInteger num =0; num <100 ; num++) {
        MsgObj * obj = [[MsgObj alloc]init];
        obj.uid = @(arc4random()%2).stringValue;
        obj.text = [self rondomStr:arc4random()%100+1];
        [self.datas addObject:obj];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString*)rondomStr:(NSInteger)len{
    NSString *base = @"五,皇,子,的,啊,打,开,束,带,结,发";
    NSArray*baseArr = [base componentsSeparatedByString:@","];
    NSMutableString *str = [NSMutableString string];
    for (NSInteger num =0; num <len ; num++) {
        [str  appendString:baseArr[arc4random()%baseArr.count]];
        
    }
    return str;
}
- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MsgObj*obj =  self.datas[indexPath.row];
    NSString* ID =[obj.uid isEqualToString:@"1"]?LeftCellID:RightCellID;
    HJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.obj= obj.text;
    
    return cell;
}



#pragma mark - IBAction

- (IBAction)sendMsgAction:(UIButton *)sender {
    
}

@end

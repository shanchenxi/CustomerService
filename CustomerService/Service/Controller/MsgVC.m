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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendBgLayoutBottom;

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
    
    self.tableView.tableFooterView = [[UIView alloc] init];

    for (NSInteger num =0; num <10 ; num++) {
        MsgObj * obj = [[MsgObj alloc]init];
        obj.uid = @(arc4random()%2).stringValue;
        obj.text = [self rondomStr:arc4random()%100+1];
        [self.datas addObject:obj];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
- (void)viewDidAppear:(BOOL)animated{
[super viewDidAppear:animated];
//    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.datas.count-1    inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.datas.count-1    inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];

}
- (void)keyboardWillChangeFrame:(NSNotification*)ntf {
    NSValue *rect = ntf.userInfo[UIKeyboardFrameEndUserInfoKey];
    NSNumber *duration = ntf.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    
    self.sendBgLayoutBottom.constant = -ScreenHeight + rect.CGRectValue.origin.y ;
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [self.view layoutIfNeeded];
    }];

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
    
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MsgObj*obj =  self.datas[indexPath.row];
    NSString* ID =[obj.uid isEqualToString:@"1"]?LeftCellID:RightCellID;
    HJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.obj= obj.text;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.msgTF resignFirstResponder];
}

#pragma mark - IBAction

- (IBAction)sendMsgAction:(UIButton *)sender {
    
    if (self.msgTF.text.length == 0) {
        [self.view showHUDWithTip:@"请输入内容"];
    }
    
    MsgObj*obj =  [[MsgObj alloc]init];

    obj.uid = @(0).stringValue;
    obj.text = self.msgTF.text;
    
    [self.datas addObject:obj];
    [self.tableView beginUpdates];

    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datas.count-1    inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

    [self.tableView endUpdates];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.datas.count-1    inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    self.msgTF.text = @"";
}

@end

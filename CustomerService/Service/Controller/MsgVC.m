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
#if DEBUG
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"模拟" style:0 target:self action:@selector(heSendMsg)];
#endif
    
    [self.tableView registerNib:[UINib nibWithNibName:LeftCellID bundle:nil] forCellReuseIdentifier:LeftCellID];
    [self.tableView registerNib:[UINib nibWithNibName:RightCellID bundle:nil] forCellReuseIdentifier:RightCellID];
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //查找表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"ServiceMsg"];
//    bquery.limit = 10;
    [bquery orderByAscending:@"updatedAt"];
    //查找GameScore表里面的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (error){
            //进行错误处理
        }else{
            
            for (BmobObject* bmob in array) {
                MsgObj *obj = [[MsgObj alloc]init];
                obj.role = [bmob objectForKey:@"role"];
                obj.text = [bmob objectForKey:@"text"];
                obj.app_store_url = [bmob objectForKey:@"app_store_url"];
                obj.img_url = [bmob objectForKey:@"img_url"];
                obj.h5_url = [bmob objectForKey:@"h5_url"];
                obj.isSend = YES;
                [self.datas addObject:obj];
            }
            [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.datas.count-1    inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }];
    
}
- (void)viewDidAppear:(BOOL)animated{
[super viewDidAppear:animated];
//    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.datas.count-1    inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];


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
    NSString* ID =[obj.role isEqualToString:@"he"]?LeftCellID:RightCellID;
    HJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.obj= obj;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgObj*obj =  self.datas[indexPath.row];
    NSURL* app_store_url = [NSURL URLWithString:obj.app_store_url];
    NSURL* h5_url = [NSURL URLWithString:obj.h5_url];

    if ([[UIApplication sharedApplication]canOpenURL:app_store_url]) {
        [[UIApplication sharedApplication]openURL:app_store_url];
    }
    else if ([[UIApplication sharedApplication]canOpenURL:h5_url]) {
        [[UIApplication sharedApplication]openURL:h5_url];
    }
    [self.msgTF resignFirstResponder];
}

#pragma mark - IBAction
- (void)sendMsg:(MsgObj*)obj{
    
    obj.isSend = NO;
    [self.datas addObject:obj];
    
    //往表添加一条数据
    BmobObject *gameScore = [BmobObject objectWithClassName:@"ServiceMsg"];
    [gameScore setObject:obj.role forKey:@"role"];
    [gameScore setObject:obj.text forKey:@"text"];
    [gameScore setObject:obj.img_url forKey:@"img_url"];
    [gameScore setObject:obj.app_store_url forKey:@"app_store_url"];
    [gameScore setObject:obj.h5_url forKey:@"h5_url"];
    
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        obj.isSend = YES;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datas.count-1    inSection:0]] withRowAnimation:UITableViewRowAnimationNone];

        
    }];
    
    
    [self.tableView beginUpdates];
    
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.datas.count-1    inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView endUpdates];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.datas.count-1    inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
    
    
}
- (IBAction)sendMsgAction:(UIButton *)sender {
    
    if (self.msgTF.text.length == 0) {
        [self.view showHUDWithTip:@"请输入内容"];
    }
    
    MsgObj*obj =  [[MsgObj alloc]init];

    obj.role = @"me";
    obj.text = self.msgTF.text;
    
    [self sendMsg:obj];
   
    self.msgTF.text = @"";
}

- (void)heSendMsg{
    
    MsgObj*obj =  [[MsgObj alloc]init];
    
    obj.role = @"he";
    obj.text = [self rondomStr:arc4random()%100+1];
    obj.img_url = @"";
    obj.app_store_url = @"https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8";
    obj.h5_url = @"https://baidu.com";

    [self sendMsg:obj];
    

}
@end

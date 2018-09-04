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
#import "ServiceKeCell.h"

static NSString *LeftCellID = @"ServiceLeftCell";
static NSString *RightCellID = @"ServiceRightCell";
static NSString *KeCellID = @"ServiceKeCell";

@interface MsgVC ()<UITableViewDelegate,UITableViewDataSource,ServiceKeCellDelegate>
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
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"模拟" style:0 target:self action:@selector(heSendMsg)];
#endif
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10.f, 0);
    [self.tableView registerNib:[UINib nibWithNibName:LeftCellID bundle:nil] forCellReuseIdentifier:LeftCellID];
    [self.tableView registerNib:[UINib nibWithNibName:RightCellID bundle:nil] forCellReuseIdentifier:RightCellID];
    [self.tableView registerNib:[UINib nibWithNibName:KeCellID bundle:nil] forCellReuseIdentifier:KeCellID];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
  
    
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
- (IBAction)moreAction {
    //查找表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"ServiceMsg"];
    //    bquery.limit = 10;
    [bquery orderByAscending:@"updatedAt"];
    //查找GameScore表里面的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        
        if (error){
            //进行错误处理
            [self.view showHUDWithTip:@"暂无更多"];

        }else{
            
            if (array.count == 0) {
                [self.view showHUDWithTip:@"暂无更多"];
                return ;
            }
            
            for (BmobObject* bmob in array) {
                MsgObj *obj = [[MsgObj alloc]init];
                obj.role = [bmob objectForKey:@"role"];
                obj.text = [bmob objectForKey:@"text"];
                obj.app_store_url = [bmob objectForKey:@"app_store_url"];
                obj.android_url = [bmob objectForKey:@"android_url"];
                obj.h5_url = [bmob objectForKey:@"h5_url"];
                obj.isSend = YES;
                [self.datas addObject:obj];
            }
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.datas.count-1    inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MsgObj*obj =  self.datas[indexPath.row];
    NSString* ID = nil;
    
    if ([obj.role isEqualToString:@"he"]) {
        ID =LeftCellID;
        
    }else if ([obj.role isEqualToString:@"me"]){
        ID =RightCellID;
        
    }else if ([obj.role isEqualToString:@"ke"]){
        ID =KeCellID;
        
    }
    
    HJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if ([cell isKindOfClass:[ServiceKeCell class]]) {
        ((ServiceKeCell*)cell).delegate = self;
    }
    cell.obj= obj;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MsgObj*obj =  self.datas[indexPath.row];
    NSURL* app_store_url = [NSURL URLWithString:obj.app_store_url];
    NSURL* android_url = [NSURL URLWithString:obj.android_url];
    
    NSURL* h5_url = [NSURL URLWithString:obj.h5_url];
    
    if ([[UIApplication sharedApplication]canOpenURL:app_store_url]) {
        [[UIApplication sharedApplication]openURL:app_store_url];
    }
    if ([[UIApplication sharedApplication]canOpenURL:android_url]) {
        [[UIApplication sharedApplication]openURL:android_url];
    }
    else if ([[UIApplication sharedApplication]canOpenURL:h5_url]) {
        [[UIApplication sharedApplication]openURL:h5_url];
    }
    [self.msgTF resignFirstResponder];
}

#pragma mark - ServiceKeCellDelegate
- (void)toURL:(UITableViewCell *)cell type:(NSInteger)type{
   NSIndexPath*indexPath = [self.tableView indexPathForCell:cell];
    MsgObj*obj =  self.datas[indexPath.row];
    NSString *urlStr = nil;
    if (type == 1) {
        [self open:obj.app_store_url];
        return;
    }else if (type == 2) {
        urlStr = obj.android_url;
    }else if (type == 3) {
        urlStr = obj.h5_url;

    }
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择浏览器打开" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *safariAction = [UIAlertAction actionWithTitle:@"Safari" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self open:[NSString stringWithFormat:@"%@",urlStr]];
    }];
    [alert addAction:safariAction];
    UIAlertAction *ucAction = [UIAlertAction actionWithTitle:@"UC" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![self open:[NSString stringWithFormat:@"ucbrowser://%@",urlStr]]) {
            [self.view showHUDWithTip:@"未检测到此浏览器"];

        }

    }];
    [alert addAction:ucAction];
    UIAlertAction *qqAction = [UIAlertAction actionWithTitle:@"QQ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![self open:[NSString stringWithFormat:@"mttbrowser://url=%@",urlStr]]) {
            [self.view showHUDWithTip:@"未检测到此浏览器"];
        }

    }];
    [alert addAction:qqAction];
    
    UIAlertAction *baiduAction = [UIAlertAction actionWithTitle:@"百度" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![self open:[NSString stringWithFormat:@"baiduboxapp://url=%@",urlStr]]) {
            if (![self open:[NSString stringWithFormat:@"BaiduSSO://url=%@",urlStr]]) {
                if (![self open:[NSString stringWithFormat:@" bdNavi://url=%@",urlStr]]) {
                    if (![self open:[NSString stringWithFormat:@" bdNavi://%@",urlStr]]) {

                [self.view showHUDWithTip:@"未检测到此浏览器"];
                    }
            }
            }
        }

    }];
    [alert addAction:baiduAction];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (BOOL)open:(NSString*)urlStr{
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:urlStr]]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlStr]];
        return YES;
    }
    return NO;
}
#pragma mark - IBAction
- (void)sendMsg:(MsgObj*)obj{
    
    obj.isSend = NO;
    [self.datas addObject:obj];
    
    //往表添加一条数据
    BmobObject *gameScore = [BmobObject objectWithClassName:@"ServiceMsg"];
    [gameScore setObject:obj.role forKey:@"role"];
    [gameScore setObject:obj.text forKey:@"text"];
    [gameScore setObject:obj.app_store_url forKey:@"app_store_url"];
    [gameScore setObject:obj.android_url forKey:@"android_url"];
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
    obj.app_store_url = @"https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8";
    obj.h5_url = @"https://baidu.com";
    obj.android_url = @"https://google.com";
    
    [self sendMsg:obj];
    
    
}
@end

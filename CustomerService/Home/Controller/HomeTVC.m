//
//  HomeTVC.m
//  CustomerService
//
//  Created by 吴宏佳 on 2018/8/28.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "HomeTVC.h"
#import "detailsVC.h"
#import <BmobSDK/Bmob.h>
#import "NewsObj.h"

static NSString* CellID = @"HomeCell";
@interface HomeTVC ()
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation HomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:CellID bundle:nil] forCellReuseIdentifier:CellID];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(header)];;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footer)];
    [self.tableView.mj_header beginRefreshing];
    
    
}
- (void)header{
    //查找表
    BmobQuery  *bquery = [BmobQuery queryWithClassName:@"news"];
    if (self.datas.count > 0) {
        NewsObj *obj = self.datas.firstObject;
        NSDate* date = [obj.updatedAt.dateAll dateByAddingTimeInterval:1];
        
        NSDictionary *condiction1 = @{@"updatedAt":@{@"$gt":@{@"__type": @"Date", @"iso": date.stringYMD_HMS}}};
        
        [bquery addTheConstraintByAndOperationWithArray:@[condiction1]];
    }
    bquery.limit = 10;
    [bquery orderByDescending:@"updatedAt"];

    
    //查找GameScore表里面的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        
        if (error){
            //进行错误处理
        }else{
            
            NSMutableArray *arr = [NSMutableArray array];
            for (BmobObject* bmob in array) {
                NewsObj *obj = [[NewsObj alloc]init];
                obj.title = [bmob objectForKey:@"title"];
                obj.text = [bmob objectForKey:@"text"];
                obj.subtitle = [bmob objectForKey:@"subtitle"];
                obj.imgs = [bmob objectForKey:@"imgs"];
                obj.updatedAt = [bmob objectForKey:@"updatedAt"];
                [arr addObject:obj];
            }
            if (self.datas.count > 0) {
                NSRange range = NSMakeRange(0, [arr count]);
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
                [self.datas insertObjects:arr atIndexes:indexSet];
            }else{
                self.datas = arr;
            }
            
            
            [self.tableView reloadData];
        }
    }];
}
- (void)footer{
    //查找表
    BmobQuery  *bquery = [BmobQuery queryWithClassName:@"news"];
    if (self.datas.count > 0) {
        NewsObj *obj = self.datas.lastObject;
        
        NSDictionary *condiction1 = @{@"updatedAt":@{@"$lt":@{@"__type": @"Date", @"iso": obj.updatedAt}}};
        
        [bquery addTheConstraintByAndOperationWithArray:@[condiction1]];
    }
    bquery.limit = 10;
    [bquery orderByDescending:@"updatedAt"];
    
    //查找GameScore表里面的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        
        if (error){
            //进行错误处理
        }else{
            
            for (BmobObject* bmob in array) {
                NewsObj *obj = [[NewsObj alloc]init];
                obj.title = [bmob objectForKey:@"title"];
                obj.text = [bmob objectForKey:@"text"];
                obj.subtitle = [bmob objectForKey:@"subtitle"];
                obj.imgs = [bmob objectForKey:@"imgs"];
                obj.updatedAt = [bmob objectForKey:@"updatedAt"];
                [self.datas addObject:obj];
            }
            [self.tableView reloadData];
        }
    }];
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
    HJTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    cell.obj = self.datas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    detailsVC *detVC = [[detailsVC alloc] init];
    detVC.newsObj = self.datas[indexPath.row];
    [self.navigationController pushViewController:detVC animated:YES];
    
}



@end

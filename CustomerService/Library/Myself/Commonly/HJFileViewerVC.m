//
//  HJFileViewerVC.m
//  Recorder
//
//  Created by lyt on 2018/4/27.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "HJFileViewerVC.h"
#import "FMDB.h"

static NSString * HJSqlitShowItem = @"HJSqlitShowItem";
NSString * const SqliteMaster = @"sqlite_master";

@interface HJFileViewerVC ()
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation HJFileViewerVC
+ (void)show{
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[HJFileViewerVC alloc]init]];
    nav.navigationBar.translucent = NO;
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:nav animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    if (self.navigationController.childViewControllers.count == 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];

    }

    if (self.filePath==nil) {
        self.filePath =  NSHomeDirectory();
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary* dic = [manager attributesOfItemAtPath:self.filePath error:nil];
    if (dic.fileType == NSFileTypeDirectory) {
        [self.datas addObjectsFromArray:[manager contentsOfDirectoryAtPath:self.filePath error:nil]];
        
    }else if ([self.filePath.pathExtension isEqualToString:@"plist"]){
        
    }else if ([self.filePath.pathExtension isEqualToString:@"sqlite"]){
        
        
    }
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - action
- (void)cancelAction{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)addAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新建目录" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeASCIICapable;
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSFileManager *manager = [NSFileManager defaultManager];
        
        NSString *path = [self.filePath stringByAppendingPathComponent:alert.textFields.firstObject.text];
        
        BOOL loob = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (loob) {
            [self.tableView reloadData];
        }else{
            NSLog(@"\n新建目录失败！\n");
        }
    }];
    [alert addAction:sure];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - get
- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellID = @"HJFileViewerCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.numberOfLines = 0;
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSString *fileName = self.datas[indexPath.row];
        NSString *newFilePath = [self.filePath stringByAppendingPathComponent:fileName];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        NSError *error = nil;
        BOOL loob = [manager removeItemAtPath:newFilePath error:&error];
        if (error) {
            NSLog(@"删除错误：%@",error);
        }
        if (loob) {
            [self.datas removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
    }];
    
    
    return @[deleteAction];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *fileName = self.datas[indexPath.row];
    NSString *newFilePath = [self.filePath stringByAppendingPathComponent:fileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSLog(@"%@",[manager attributesOfItemAtPath:newFilePath error:nil]);
    
    BOOL isDir = NULL;
    BOOL isExists = [manager fileExistsAtPath:newFilePath isDirectory:&isDir];
    if (isExists) {
        if (isDir) {
            HJFileViewerVC *vc = [[HJFileViewerVC alloc]init];
            
            vc.filePath = newFilePath;
            vc.title = fileName;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([fileName.pathExtension isEqualToString:@"plist"]){
            
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:newFilePath];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"plist" message:[NSString stringWithFormat:@"%@",dic] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancel];
            
            [self presentViewController:alert animated:YES completion:nil];
        }else if ([fileName.pathExtension isEqualToString:@"sqlite"] || [fileName.pathExtension isEqualToString:@"db"]){
            
            HJSqlitShowVC *vc = [[HJSqlitShowVC alloc]init];
            vc.filePath = newFilePath;
            vc.title = fileName;
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }
    }
}

@end


#pragma mark - sqlite部分
@class HJTableLayout;
@protocol HJTableLayoutDelegate <UICollectionViewDelegate>

@optional
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(HJTableLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)isFixedWidth;
@end

@interface HJTableLayout : UICollectionViewLayout
//@property (nonatomic, weak) id<HJTableLayoutDelegate> delegate;

/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
@property (nonatomic, strong) NSMutableArray *columnWidthArray;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *lastAttrs;
@property (nonatomic, assign) CGSize contentSize;

@property (nonatomic, assign) CGFloat lastX;
- (CGSize)itemSizeIndexPath:(NSIndexPath*)indexPath;

@end

@implementation HJTableLayout
#pragma mark - get

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
- (NSMutableArray *)columnWidthArray
{
    if (!_columnWidthArray) {
        _columnWidthArray = [NSMutableArray array];
    }
    return _columnWidthArray;
}

#pragma mark - 触发代理


- (CGSize)itemSizeIndexPath:(NSIndexPath*)indexPath{
    if ([(id<HJTableLayoutDelegate>)self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [(id<HJTableLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }else{
        return CGSizeZero;
    }
}


#pragma mark - 自定义布局
- (void)prepareLayout{
    //    self.contentHeight = 0;
    //
    //    // 清除以前计算的所有高度
    //    [self.columnHeights removeAllObjects];
    //    for (NSInteger i = 0; i < self.columnCount; i++) {
    //        [self.columnHeights addObject:@(self.edgeInsets.top)];
    //    }
    
    // 清除之前所有的布局属性
    [self.attrsArray removeAllObjects];
    [self.columnWidthArray removeAllObjects];
    self.lastAttrs.frame = CGRectZero;
    self.contentSize = CGSizeZero;
    
    
    
    
    NSInteger maxCols = 0;
    
    NSMutableArray * rowArr = [NSMutableArray array];
    
    NSInteger rows = [self.collectionView numberOfSections];
    
    for (NSInteger row = 0; row < rows; row++) {
        
        NSMutableArray * colArr = [NSMutableArray array];
        
        NSInteger cols = [self.collectionView numberOfItemsInSection:row];
        if (maxCols < cols) {
            maxCols = cols;
        }
        for (NSInteger col = 0; col < cols; col++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:col inSection:row];
            
            CGFloat colW = [self itemSizeIndexPath:indexPath].width;
            [colArr addObject:@(colW)];
        }
        [rowArr addObject:colArr];
    }
    
    
    for (NSInteger col = 0; col < maxCols; col++) {
        CGFloat maxW = 0;

        
        for (NSInteger row = 0; row < rows; row++) {
            NSArray *colArr = rowArr[row];
            if (colArr.count > col) {
                NSNumber *colW = colArr[col];

                if (maxW <  colW.floatValue) {
                    maxW =  colW.floatValue;
                }
                if (row == rows - 1) {
                    [self.columnWidthArray addObject:@(maxW)];
                }
            }
        }
    }
    
    
    
    //
    
    
    NSInteger sections = [self.collectionView numberOfSections];
    
    for (NSInteger section = 0; section < sections; section++) {
        // 开始创建每一个cell对应的布局属性
        NSInteger items = [self.collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0; item < items; item++) {
            // 创建位置
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            // 获取indexPath位置cell对应的布局属性
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArray addObject:attrs];
        }
    }
    
}
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.contentSize.width + 5.f, self.contentSize.height + 5.f);
}
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat space = 5.f;
    NSInteger column = indexPath.item ;
    NSInteger row = indexPath.section ;
    
    CGFloat atW = [self itemSizeIndexPath:indexPath].width;
    CGFloat atH = [self itemSizeIndexPath:indexPath].height;
    
    atW = [self.columnWidthArray[column] floatValue];
    
    if (column == 0) {
        self.lastX = 0;
    }
    CGFloat atX = space + self.lastX;
    CGFloat atY = space + (atH + space) * row;
    
    
    attrs.frame = CGRectMake(atX, atY, atW, atH);
    
    CGFloat curMaxX =  CGRectGetMaxX(attrs.frame);
    CGFloat curMaxY =  CGRectGetMaxY(attrs.frame);
    self.lastX = curMaxX;
    
    
    
    CGSize contentSize = self.contentSize;
    if (contentSize.width < curMaxX) {
        contentSize.width = curMaxX;
    }
    if (contentSize.height < curMaxY) {
        contentSize.height = curMaxY;
        
    }
    self.contentSize = contentSize;
    
    return attrs;
}

@end

@interface HJSqlitShowVC ()<HJTableLayoutDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *datas;
@property (strong, nonatomic) FMDatabaseQueue *queue;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) BOOL isTableView;


@end
@implementation HJSqlitShowVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"表格" forState: UIControlStateNormal];
    [btn setTitle:@"集合" forState: UIControlStateSelected];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(changeLayout:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 50., 44.f);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self changeLayout:btn];
    
    self.datas = [self obtain];
    
    
}
- (NSMutableArray *)obtain{
    
    if (self.tableName == nil) {
        self.tableName = SqliteMaster;
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@;",self.tableName];// WHERE type='table' ORDER BY name
    
    // 1.定义
    NSMutableArray *mutArr = [NSMutableArray array];
    
    // 2.使用数据库
    [self.queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *rs = [db executeQuery:sql];
        //
        NSMutableArray *columnNames = [NSMutableArray array];
        for (int num = 0; num < rs.columnCount; num++) {
            
            [columnNames addObject:[rs columnNameForIndex:num]];
            
        }
        
        [mutArr addObject:columnNames];
        
        while(rs.next) {
            
            NSMutableArray *columnContents = [NSMutableArray array];
            for (int num = 0; num < rs.columnCount; num++) {
                NSString *str = [rs stringForColumnIndex:num];
                [columnContents addObject:str?str:@""];
                
            }
            [mutArr addObject:columnContents];
        }
        
        [rs close];
    }];
    
    // 3.返回数据
    return mutArr;
    
}
#pragma mark - action
- (void)changeLayout:(UIButton *)btn{
    btn.selected = !btn.isSelected;
    
    UIView *currentView = nil;
    
    self.isTableView = btn.selected;
    if (self.isTableView) {
        [self.collectionView removeFromSuperview];
        self.collectionView = nil;
        [self.view addSubview:self.tableView];
        currentView = self.tableView;
    }else{
        [self.tableView removeFromSuperview];
        self.tableView = nil;
        [self.view addSubview:self.collectionView];
        currentView = self.collectionView;
        
    }
    
    NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
    NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.f constant:0];
    NSLayoutConstraint * right = [NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
    NSLayoutConstraint * bottom = [NSLayoutConstraint constraintWithItem:currentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
    [self.view addConstraints:@[top,left,right,bottom]];
    
}
#pragma mark - get
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        HJTableLayout *layout = [[HJTableLayout alloc]init] ;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:HJSqlitShowItem];
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44.f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}
- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
- (FMDatabaseQueue *)queue{
    if (!_queue) {
        _queue = [FMDatabaseQueue databaseQueueWithPath:self.filePath];
    }
    return _queue;
}
#pragma mark - HJTableLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(HJTableLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString* text = self.datas[indexPath.section][indexPath.row];
    //        CGFloat height = [text boundingRectWithSize:CGSizeMake(100.f, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.f]} context:nil].size.height;
    //        return  CGSizeMake(100.f, height);
    CGFloat width = [text boundingRectWithSize:CGSizeMake(MAXFLOAT,20.f) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.f]} context:nil].size.width;

    return  CGSizeMake(width+20.f, 20.f);
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.datas.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.datas[section];
    return arr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJSqlitShowItem forIndexPath:indexPath];
    NSInteger tag = 7643875;
    UILabel *lab = [cell.contentView viewWithTag:tag];
    UILabel *indexLab = [cell.contentView viewWithTag:tag+1];
    if (!lab) {
        cell.contentView.backgroundColor = [UIColor whiteColor];

        lab = [[UILabel alloc]init];
        [cell.contentView addSubview:lab];
        lab.tag = tag;
        lab.numberOfLines = 0;
        lab.font = [UIFont systemFontOfSize:16.f];
        lab.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:lab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
        NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:lab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeLeft multiplier:1.f constant:0];
        NSLayoutConstraint * right ;//= [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:lab attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
        NSLayoutConstraint * bottom = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:lab attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
        [cell.contentView addConstraints:@[top,left,bottom]];
        
        
        indexLab = [[UILabel alloc]init];
        [cell.contentView addSubview:indexLab];
        indexLab.tag = tag+1;
        indexLab.numberOfLines = 0;
        indexLab.font = [UIFont systemFontOfSize:16.f];
        indexLab.translatesAutoresizingMaskIntoConstraints = NO;
        indexLab.textColor = [UIColor blueColor];
        
        top = [NSLayoutConstraint constraintWithItem:indexLab attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell.contentView attribute:NSLayoutAttributeTop multiplier:1.f constant:0];
        left = [NSLayoutConstraint constraintWithItem:indexLab attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:lab attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
        right = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:indexLab attribute:NSLayoutAttributeRight multiplier:1.f constant:0];
        bottom = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:indexLab attribute:NSLayoutAttributeBottom multiplier:1.f constant:0];
        NSLayoutConstraint * width = [NSLayoutConstraint constraintWithItem:indexLab attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:10.f];

        [cell.contentView addConstraints:@[top,left,right,bottom,width]];
        
        
    }
    lab.textColor = indexPath.section == 0 ? [UIColor orangeColor]: [UIColor blackColor];
    lab.text = self.datas[indexPath.section][indexPath.row];
    indexLab.text = indexPath.section == 0 ? @"": [NSString stringWithFormat:@"%ld",indexPath.section-1];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }
    NSArray *titles = self.datas.firstObject;
    NSString *title = titles[indexPath.row];
    NSInteger index = [titles indexOfObject:@"name"];
    
    if (self.tableName == SqliteMaster) {
        HJSqlitShowVC *vc = [[HJSqlitShowVC alloc]init];
        vc.filePath = self.filePath;
        vc.tableName = self.datas[indexPath.section][index];
        vc.title = self.datas[indexPath.section][index];
        [self.navigationController pushViewController:vc animated:YES];
        
    }

    NSString * text = self.datas[indexPath.section][indexPath.row];
    [UIPasteboard generalPasteboard].string = text;
    NSLog(@"\n%@\n",text);

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count - 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.datas[section+1];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellID = @"HJSqlitShowCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
    }
    
    NSString *title = self.datas.firstObject[indexPath.row];
    NSString *text = self.datas[indexPath.section+1][indexPath.row];
    
    NSMutableAttributedString *titleAttr = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    
    NSAttributedString *textAttr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" : %@",text]];
    [titleAttr appendAttributedString:textAttr];
    
    
    cell.textLabel.attributedText = titleAttr;
    return cell;
}
#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"第%ld条数据",section];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titles = self.datas.firstObject;
    NSInteger index = [titles indexOfObject:@"name"];
    
    if (self.tableName == SqliteMaster) {
        HJSqlitShowVC *vc = [[HJSqlitShowVC alloc]init];
        vc.filePath = self.filePath;
        vc.tableName = self.datas[indexPath.section+1][index];
        vc.title = self.datas[indexPath.section+1][index];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    NSString * text = self.datas[indexPath.section+1][indexPath.row];
    [UIPasteboard generalPasteboard].string = text;
    NSLog(@"\n%@\n",text);
}
@end


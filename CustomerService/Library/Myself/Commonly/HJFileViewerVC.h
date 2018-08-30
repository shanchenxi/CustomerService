//
//  HJFileViewerVC.h
//  Recorder
//
//  Created by lyt on 2018/4/27.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import <UIKit/UIKit.h>

////需要fmdb
////.plist  .sqlit

@interface HJFileViewerVC : UITableViewController
+ (void)show;
@property (strong, nonatomic) NSString *filePath;
//- (void)setFilePath:(NSString *)filePath ;
@end



@interface HJSqlitShowVC : UIViewController

@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) NSString *tableName;

@end

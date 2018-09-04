//
//  ServiceKeCell.h
//  CustomerService
//
//  Created by 吴宏佳 on 2018/9/2.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "HJKit.h"
@protocol ServiceKeCellDelegate <NSObject>

@required
- (void)toURL:(UITableViewCell*)cell type:(NSInteger)type;
@end

@interface ServiceKeCell : HJTableViewCell
@property (weak, nonatomic) id<ServiceKeCellDelegate> delegate;

@end


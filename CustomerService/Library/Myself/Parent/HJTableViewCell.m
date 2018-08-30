//
//  HJTableViewCell.m
//  Gorgeous
//
//  Created by 吴宏佳 on 2018/4/21.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "HJTableViewCell.h"
#import "OftenUse.h"

@implementation HJTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self defaultSet];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self defaultSet];
}
- (void)defaultSet{
    self.textLabel.textColor = HJCOLOR3;
}
- (void)setIsShowAccessory:(BOOL)isShowAccessory{
    _isShowAccessory = isShowAccessory;
    self.accessoryView = isShowAccessory?[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me1_20"]]:nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ServiceKeCell.m
//  CustomerService
//
//  Created by 吴宏佳 on 2018/9/2.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "ServiceKeCell.h"
#import "MsgObj.h"

@interface ServiceKeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;

@end
@implementation ServiceKeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImgView.layer.cornerRadius = 3.f;
    self.bgImgView.layer.cornerRadius = 5.f;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setObj:(id)obj{
    [super setObj:obj];

}
- (IBAction)iosAction {
    MsgObj *mObj = self.obj;
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:mObj.app_store_url]]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:mObj.app_store_url]];
    }
}
- (IBAction)androidAction {
    MsgObj *mObj = self.obj;
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:mObj.android_url]]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:mObj.android_url]];
    }
}
- (IBAction)h5Action {
    MsgObj *mObj = self.obj;
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:mObj.h5_url]]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:mObj.h5_url]];
    }
}
@end

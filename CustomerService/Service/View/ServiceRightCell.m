//
//  ServiceRightCell.m
//  CustomerService
//
//  Created by 吴宏佳 on 2018/9/1.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "ServiceRightCell.h"
#import "MsgObj.h"

@interface ServiceRightCell ()
@property (weak, nonatomic) IBOutlet UILabel *textLab;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textLayoutW;
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aiView;

@end
@implementation ServiceRightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImgView.layer.cornerRadius = 3.f;
    self.bgImgView.layer.cornerRadius = 5.f;
    
    self.textLayoutW.constant = ScreenWidth - 74.f*2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setObj:(id)obj{
    [super setObj:obj];
    MsgObj *mObj = obj;
    self.textLab.text = mObj.text;
    
    if (mObj.isSend) {
        [self.aiView stopAnimating];
    }else{
        [self.aiView startAnimating];

    }
}
@end

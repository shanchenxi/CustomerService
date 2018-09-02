//
//  HomeCell.m
//  CustomerService
//
//  Created by 吴宏佳 on 2018/8/28.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "HomeCell.h"
#import "NewsObj.h"

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}
- (void)setObj:(id)obj{
    [super setObj:obj];
    NewsObj *nObj = obj;
    self.titleLab.text = nObj.title;
    self.subTitleLab.text = nObj.subtitle;
    NSString*urlStr = [nObj.imgs componentsSeparatedByString:@","][0];
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
}
@end

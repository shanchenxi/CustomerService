//
//  ImgZoomVC.h
//  CeDaYeWu
//
//  Created by ceyu on 2017/4/6.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ImgZoomVCShow(imgURLs,index)  if (imgURLs > 0) {ImgZoomVC *vc = [[ImgZoomVC alloc] init];[vc setImgURLs:imgURLs withIndex:index];[self presentViewController:vc animated:YES completion:nil];}

@interface ImgZoomVC : UIViewController
/**图片地址数组*/
@property (copy, nonatomic) NSArray<NSURL*>* imgURLs;
-(void)setImgURLs:(NSArray<NSURL *> *)imgURLs withIndex:(NSInteger)index;
@end








@protocol ImgZoomCellDelegate <NSObject>

@required
-(void)back;
-(void)longPress:(UIImage *)image;
@end

@interface ImgZoomCell : UICollectionViewCell
/**图片地址*/
@property (copy, nonatomic) NSURL* imgURL;

@property (weak, nonatomic) id<ImgZoomCellDelegate> delegate;

@end

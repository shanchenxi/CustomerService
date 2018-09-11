//
//  ImgZoomVC.m
//  CeDaYeWu
//
//  Created by ceyu on 2017/4/6.
//  Copyright © 2017年 吴宏佳. All rights reserved.
//

#import "ImgZoomVC.h"
#import "UIImageView+WebCache.h"
#import "UIView+Tool.h"

@interface ImgZoomVC ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ImgZoomCellDelegate>
@property (weak, nonatomic) UIPageControl* pageCtrl;
@property (weak, nonatomic) UICollectionView* collectionView;

@end

@implementation ImgZoomVC

static NSString * const reuseIdentifier = @"ImgZoomVCCell";
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        UIPageControl* pageCtrl = [[UIPageControl alloc]init];
        [self.view addSubview:pageCtrl];
        pageCtrl.enabled = NO;
        pageCtrl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageCtrl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageCtrl.frame = CGRectMake(0, self.view.frame.size.height - 60.f, self.view.frame.size.width, 20.f);
        self.pageCtrl = pageCtrl;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    collectionView.delegate =self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    [collectionView registerClass:[ImgZoomCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView = collectionView;

}
-(void)setImgURLs:(NSArray<NSURL *> *)imgURLs{
    _imgURLs = imgURLs;
    self.pageCtrl.numberOfPages = imgURLs.count;

}
-(void)setImgURLs:(NSArray<NSURL *> *)imgURLs withIndex:(NSInteger)index{
    self.imgURLs = imgURLs;
    
    self.pageCtrl.currentPage = index;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgURLs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImgZoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.imgURL = self.imgURLs[indexPath.item];
    return cell;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}

#pragma mark - <UICollectionViewDelegate>
#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint scrollPoint = scrollView.contentOffset;
    
    if (scrollView == self.collectionView){
        self.pageCtrl.currentPage = scrollPoint.x/scrollView.frame.size.width;
    }
}
#pragma mark - ImgZoomCellDelegate
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)longPress:(UIImage *)image{

    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"SaveAlbum", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:sureAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma  mark - 保存到相册触发事件

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSString *message = error == NULL?NSLocalizedString(@"Success", nil) :NSLocalizedString(@"Failure", nil);
    [self.view showHUDWithTip:message];
    
}
@end

#pragma mark - 类ImgZoomCell
@interface ImgZoomCell ()<UIScrollViewDelegate>
{
    BOOL _isZoom;
}
/**图*/
@property (strong, nonatomic) UIImageView* imgView;
/***/
@property (weak, nonatomic) UIScrollView* scrollView;

@end
@implementation ImgZoomCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        frame.origin = CGPointZero;
        
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:frame];
        [self.contentView addSubview:scrollView];
        scrollView.delegate = self;
        //设置最大伸缩比例
        scrollView.maximumZoomScale= 2.0 ;
        //设置最小伸缩比例
        scrollView.minimumZoomScale= 0.5 ;
        self.scrollView = scrollView;
        
        //
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:scrollView.bounds];
        [scrollView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        //
        UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        oneTap.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:oneTap];
        
        UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        twoTap.numberOfTapsRequired = 2;
        [imageView addGestureRecognizer:twoTap];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [imageView addGestureRecognizer:longPress];
        //如果不加下面的话，当单指双击时，会先调用单指单击中的处理，再调用单指双击中的处理
        [oneTap requireGestureRecognizerToFail:twoTap];
        
        self.imgView = imageView;
    }
    return self;
}
-(void)setImgURL:(NSURL *)imgURL{
    _imgURL = imgURL;
    
    [self.contentView hiddenHUD];
    [self.contentView showHUD];
    __weak __typeof(self)wself = self;
    [self.imgView sd_setImageWithURL:imgURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [wself.contentView hiddenHUD];

    } ];
    [self.scrollView setZoomScale:1.f animated:YES];
    _isZoom = NO;
}
-(void)tap:(UITapGestureRecognizer*)tap{
    _isZoom = !_isZoom;
    
    switch (tap.numberOfTapsRequired) {
        case 1:
            [self.delegate back];
            break;
            
        case 2:
            [self.scrollView setZoomScale:_isZoom?2.f:1.f  animated:YES];
            break;
    }
}
-(void)longPress:(UILongPressGestureRecognizer*)longPress{
    if (self.imgView.image) {
        [self.delegate longPress:self.imgView.image];
    }
   
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    
    //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    self.imgView.center = CGPointMake(xcenter, ycenter);
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imgView;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:( UIView *)view {
    
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    
}

@end

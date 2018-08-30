//
//  MoreChoiceVC.m
//  mx
//
//  Created by lyt on 2018/4/12.
//  Copyright © 2018年 chinasns. All rights reserved.
//

#import "MoreChoiceVC.h"
#import "OftenUse.h"
#import "Masonry.h"
static NSString * cellID = @"MoreChoiceCell";

@implementation MoreChoiceObj
+ (instancetype)createImgName:(NSString *)imgName withTitle:(NSString *)title withKey:(NSString *)key{
    MoreChoiceObj * obj = [[self alloc]init];
    obj.imgName = imgName;
    obj.title = title;
    obj.key = key;
    return obj;
}

@end
@interface MoreChoiceCell : UICollectionViewCell

@property (strong, nonatomic) MoreChoiceObj *obj;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *label;

@end
@implementation MoreChoiceCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imgView = [[UIImageView alloc]init];
        [self.contentView addSubview:imgView];
        self.imageView = imgView;
        
        UILabel *lab = [[UILabel alloc]init];
        [self.contentView addSubview:lab];
        lab.textColor = HJCOLOR3;
        self.label = lab;
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(@20.f);
        }];
        
        [lab makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(imgView.bottom).offset(5.f);
        }];
    }
    return self;
}
- (void)setObj:(MoreChoiceObj *)obj{
    _obj = obj;
    self.label.text = obj.title;
    self.imageView.image = [UIImage imageNamed:obj.imgName];
}
@end

@interface MoreChoiceVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgLayoutBottom;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (copy, nonatomic) void (^moreChoiceBlock)(NSString *);
@property (strong, nonatomic) NSArray<MoreChoiceObj*> *datas;

@end

@implementation MoreChoiceVC
+ (void)addObj:(void (^)(NSMutableArray *))block completion:(void (^)(NSString *))completion{
    MoreChoiceVC *vc = [MoreChoiceVC create];
    [vc addObj:block];
    [vc completion:completion];
    [[[[UIApplication sharedApplication]keyWindow] rootViewController] presentViewController:vc animated:YES completion:nil];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(ScreenWidth/4, 125.f);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    flow.sectionInset = UIEdgeInsetsZero;
    
    self.collectionView.collectionViewLayout = flow;
    [self.collectionView registerClass:[MoreChoiceCell class] forCellWithReuseIdentifier:cellID];
    
    self.bgLayoutBottom.constant = -200.f;
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    self.titleLab.text = self.title;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.bgLayoutBottom.constant = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self.view layoutIfNeeded];
    }];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelAction];
}
- (IBAction)cancelAction {
    
    self.bgLayoutBottom.constant = -200.f;
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}
- (void)setDatas:(NSArray<MoreChoiceObj *> *)datas{
    _datas = datas;
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MoreChoiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.obj = self.datas[indexPath.row];
    return cell;
    
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self cancelAction];
    
    MoreChoiceObj *obj = self.datas[indexPath.row];
    if (self.moreChoiceBlock) {
        self.moreChoiceBlock(obj.key);
    }
    
}
- (void)addObj:(void (^)(NSMutableArray *))block{
    NSMutableArray *objs = [NSMutableArray array];
    if (block) {
        block(objs);
    }
    self.datas = objs;
    [self.collectionView reloadData];
}
- (void)completion:(void (^)(NSString *))completion{
    self.moreChoiceBlock = completion;
}

- (void)dealloc{
    
}
@end

//
//  setIconVC.m
//  CustomerService
//
//  Created by 单晨曦 on 2018/8/31.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

//RGB
#define RGB(r,g,b)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#import "setIconVC.h"
#import "HJKit.h"

@interface setIconVC ()<UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UIButton *openPhotoBtn;
@property (nonatomic,strong) UIButton *takePhotoBtn;

@end

@implementation setIconVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(246, 245, 246);
    self.navigationItem.title = @"设置个人头像";
    //
    [self createUI];
}
- (void)createUI{
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.image = [UIImage imageNamed:@"img_mainUrl"];
    [self.view addSubview:self.iconImageView];
    [_iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0.f);
        make.height.equalTo(375);
    }];
    
    self.openPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.openPhotoBtn.backgroundColor = [UIColor whiteColor];
    self.openPhotoBtn.clipsToBounds = YES;
    self.openPhotoBtn.layer.cornerRadius = 5;
    [self.openPhotoBtn.layer setMasksToBounds:YES];
    [self.openPhotoBtn.layer setBorderColor:RGB(191, 191, 191).CGColor];
    [self.openPhotoBtn.layer setBorderWidth:1];
    [self.openPhotoBtn setTitle:@"从相册选一张" forState:UIControlStateNormal];
    [self.openPhotoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.openPhotoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.openPhotoBtn addTarget:self action:@selector(openPhotoBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.openPhotoBtn];
    [_openPhotoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.bottom).offset(41.f);
        make.centerX.equalTo(0.f);
        make.height.equalTo(51);
        make.width.equalTo(240.f);
    }];
    self.takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.takePhotoBtn.backgroundColor = [UIColor whiteColor];
    self.takePhotoBtn.clipsToBounds = YES;
    self.takePhotoBtn.layer.cornerRadius = 5;
    [self.takePhotoBtn.layer setMasksToBounds:YES];
    [self.takePhotoBtn.layer setBorderColor:RGB(191, 191, 191).CGColor];
    [self.takePhotoBtn.layer setBorderWidth:1];
    [self.takePhotoBtn setTitle:@"拍一张照片" forState:UIControlStateNormal];
    [self.takePhotoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.takePhotoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.takePhotoBtn];
    [self.takePhotoBtn addTarget:self action:@selector(takePhotoBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [_takePhotoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.openPhotoBtn.bottom).offset(20.f);
        make.centerX.equalTo(0.f);
        make.height.equalTo(51);
        make.width.equalTo(240.f);
    }];
}
//打开相册
- (void)openPhotoBtnEvent{
    [self openPhotoLibrary];
}
//打开相机
- (void)takePhotoBtnEvent{
    [self takePhoto];
}
- (void)openPhotoLibrary{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        //1.初始化相册拾取器
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        //2.设置代理
        controller.delegate = self;
        //3.设置资源：
        /**
         UIImagePickerControllerSourceTypePhotoLibrary,相册
         UIImagePickerControllerSourceTypeCamera,相机
         UIImagePickerControllerSourceTypeSavedPhotosAlbum,照片库
         */
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //4.随便给他一个转场动画
        controller.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion:NULL];
    }else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}
#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    self.iconImageView.image = info[UIImagePickerControllerOriginalImage];
}
// 开始拍照
-(void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //应该先检查相机可用是否
        [self presentViewController:picker animated:YES completion:nil];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
        [alert show];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

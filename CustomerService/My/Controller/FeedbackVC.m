//
//  FeedbackVC.m
//  CustomerService
//
//  Created by 单晨曦 on 2018/9/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FeedbackVC.h"
#import "shanTextView.h"
#import "HJKit.h"

@interface FeedbackVC ()<UITextViewDelegate>
@property (nonatomic, weak)shanTextView *textV;

@property (strong, nonatomic) UIButton *button;
@end

@implementation FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HJRGBA(245, 245, 245, 1);
    
    shanTextView *textV = [[shanTextView alloc] init];
    textV.font = [UIFont systemFontOfSize:15];
    textV.layer.cornerRadius = 5;
    textV.keyboardType = UIKeyboardTypeDefault;
    textV.delegate = self;
    textV.placeholder = @"有什么要求尽管提...";
    self.textV = textV;
    textV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textV];
    [textV makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(200);
    }];
    
    self.button = [UIButton buttonWithType: UIButtonTypeCustom];
    [self.button setTitle:@"确定" forState:UIControlStateNormal];
    self.button.backgroundColor = MassTone;
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = 5.0;
    //设置button不能点击
    [self.button setUserInteractionEnabled:NO];
    self.button.titleLabel.alpha = 0.4;
    [self.button addTarget:self action:@selector(ButtonMethod) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button];
    [_button makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textV.bottom).offset(15.f);
        make.left.equalTo(12.f);
        make.right.equalTo(-12.f);
        make.height.equalTo(50.f);
    }];

    
}
- (void)ButtonMethod{
    [self.textV endEditing:YES];
    [self.view showHUDWithTip:@"反馈成功"];
}
- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"%@",self.textV.text);
    if (_textV.text.length >= 1) {
        //设置button可以点击
        [self.button setUserInteractionEnabled:YES];
        self.button.titleLabel.alpha = 1;
    }else{
        [self.button setUserInteractionEnabled:NO];
        self.button.titleLabel.alpha = 0.4;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (range.location>=200){
        //控制输入文本的长度
        return  NO;
    }else{
        return  YES;
    }
}
#pragma mark - 收键盘手势触发事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textV endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

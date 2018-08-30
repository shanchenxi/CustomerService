
//
//  HJTextView.m
//  mx
//
//  Created by lyt on 2017/12/1.
//  Copyright © 2017年 chinasns. All rights reserved.
//

#import "HJTextView.h"

@interface HJTextView ()
@property (strong, nonatomic) UILabel *placeholderLab;

@end

@implementation HJTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(UILabel *)placeholderLab{
    if (!_placeholderLab) {
        _placeholderLab = [[UILabel alloc]init];
        [self addSubview:_placeholderLab];
        _placeholderLab.font = self.font;
        _placeholderLab.numberOfLines = 0;
        _placeholderLab.textColor = [UIColor lightGrayColor];
        _placeholderLab.translatesAutoresizingMaskIntoConstraints = NO;
        CGFloat space = 10.f;
        NSLayoutConstraint* leftLayout = [NSLayoutConstraint
                                          
                                          constraintWithItem:_placeholderLab//被约束View对象
                                          
                                          attribute:NSLayoutAttributeLeft//被约束的值
                                          
                                          relatedBy:NSLayoutRelationEqual//约束类型
                                          
                                          toItem:self//约束依赖对象
                                          
                                          attribute:NSLayoutAttributeLeft//约束的值
                                          
                                          multiplier:1.0f
                                          
                                          constant:space//偏移量
                                          
                                          ];
        
        
        [self addConstraint:leftLayout];
        NSLayoutConstraint* topLayout = [NSLayoutConstraint
                                         
                                         constraintWithItem:_placeholderLab//被约束View对象
                                         
                                         attribute:NSLayoutAttributeTop//被约束的值
                                         
                                         relatedBy:NSLayoutRelationEqual//约束类型
                                         
                                         toItem:self//约束依赖对象
                                         
                                         attribute:NSLayoutAttributeTop//约束的值
                                         
                                         multiplier:1.0f
                                         
                                         constant:space//偏移量
                                         
                                         ];
        
        
        [self addConstraint:topLayout];
        NSLayoutConstraint* rightLayout = [NSLayoutConstraint
                                           
                                           constraintWithItem:_placeholderLab//被约束View对象
                                           
                                           attribute:NSLayoutAttributeRight//被约束的值
                                           
                                           relatedBy:NSLayoutRelationEqual//约束类型
                                           
                                           toItem:self//约束依赖对象
                                           
                                           attribute:NSLayoutAttributeRight//约束的值
                                           
                                           multiplier:1.0f
                                           
                                           constant:space//偏移量
                                           
                                           ];
        
        
        [self addConstraint:rightLayout];
        
    }
    
    return _placeholderLab;
}
-(void)setPlaceholder:(NSString*)placeholder{
    _placeholder = placeholder;
    if (placeholder.length > 0) {
        
        
        self.placeholderLab.text = placeholder;
        
        //添加监听者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChangeNotification:) name:UITextViewTextDidChangeNotification object:nil];
    }
}

/**
 *  监听属性值发生改变时回调
 */
- (void)textViewTextDidChangeNotification:(NSNotification *)notification{
    self.placeholderLab.hidden = self.hasText;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

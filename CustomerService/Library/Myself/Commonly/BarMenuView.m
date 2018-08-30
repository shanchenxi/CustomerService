//
//  BidBarMenuView.m
//  mx
//
//  Created by lyt on 2017/11/30.
//  Copyright © 2017年 chinasns. All rights reserved.
//

#import "BarMenuView.h"

#define labFont [UIFont systemFontOfSize:18.f]
const CGFloat rowH = 44.f;
const CGFloat cornerR = 0;

static NSString *cellID = @"BarMenuView";


@interface BarCell:UITableViewCell
- (instancetype)init;
@property (weak, nonatomic) UILabel *lab;
@property (weak, nonatomic) UIView *grayLine;
@property (strong, nonatomic) NSString *text;


@end
@implementation BarCell
- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    if (self) {
        UILabel *lab = [[UILabel alloc]init];
        [self.contentView addSubview:lab];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor whiteColor];
        lab.font = labFont;
        self.lab = lab;
        
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        UIView *grayLine = [[UIView alloc]init];
        grayLine.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:grayLine];
        self.grayLine = grayLine;
    }
    return self;
}

-(void)layoutSubviews{
    self.grayLine.frame = CGRectMake(0, rowH - 1.f, self.contentView.frame.size.width, 1.f);
    self.lab.frame = CGRectMake(0, 0, self.contentView.frame.size.width, rowH - 1.f);
}
-(void)setText:(NSString *)text{
    
    self.lab.text = text;
}
@end

@interface BarMenuView()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableLayoutH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableLayoutW;
@property (copy, nonatomic) void (^completionBlock)(NSInteger, NSString *);
@property (copy, nonatomic) void (^viewDidDisappearBlock)(void);

@end

@implementation BarMenuView
+ (instancetype)addObj:(void (^)(NSMutableArray *))block completion:(void (^)(NSInteger, NSString *))completion viewDidDisappear:(void (^)(void))viewDidDisappear{
    BarMenuView * view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    
    [view addObj:block];
    [view completion:completion];
    [view viewDidDisappear:viewDidDisappear];
    
    return view;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    
        self.bgView.layer.cornerRadius = cornerR;
    //    self.bgView.layer.masksToBounds = NO;
    
    //阴影
    //    self.bgView.layer.shadowColor = RGB_COLOR(225.f, 235.f, 236.f).CGColor;
    self.bgView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(3.f, 3.f); //[水平偏移, 垂直偏移]
    self.bgView.layer.shadowOpacity = 1.f; // 0.0 ~ 1.0 的值
    self.bgView.layer.shadowRadius = 3.f; // 阴影发散的程度
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self removeFromSuperview];
    if (self.viewDidDisappearBlock) {
        self.viewDidDisappearBlock();
    }
    
}

-(void)setTitles:(NSArray *)titles{
    _titles =titles;
    
    //计算table宽
    CGFloat maxW = 0;
    for (NSString *str in titles) {
        CGFloat tableW = [str sizeWithAttributes:@{NSFontAttributeName:labFont}].width;
        if (maxW < tableW) {
            maxW = tableW;
        }
    }
    self.tableLayoutW.constant = maxW + 15.f;
    //计算table高
    CGFloat tableH  = 0;
    NSInteger rows  = titles.count;
    if (rows < 5) {
        tableH = rows* rowH ;
        self.tableView.scrollEnabled = NO;

    }else{
        tableH = 5 *rowH;
        self.tableView.scrollEnabled = YES;
    }
    self.tableLayoutH.constant = tableH + cornerR* 2;
    
    [self.tableView reloadData];

}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[BarCell alloc]init];
    }
    cell.text = self.titles[indexPath.row];
    cell.grayLine.hidden = indexPath.row+1 == self.titles.count;
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.completionBlock) {
        self.completionBlock(indexPath.row, self.titles[indexPath.row]);
    }
    [self removeFromSuperview];
    if (self.viewDidDisappearBlock) {
        self.viewDidDisappearBlock();
    }

}

#pragma mark -
- (void)addObj:(void (^)(NSMutableArray *))block{
    NSMutableArray *objs = [NSMutableArray array];
    if (block) {
        block(objs);
    }
    self.titles = objs;
    [self.tableView reloadData];
}
- (void)completion:(void (^)(NSInteger,NSString *))completion{
    self.completionBlock = completion;
}
- (void)viewDidDisappear:(void (^)(void))block{
    self.viewDidDisappearBlock  = block;
}

- (void)dealloc{
    
}
@end

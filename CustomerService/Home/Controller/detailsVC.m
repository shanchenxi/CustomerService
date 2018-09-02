//
//  detailsVC.m
//  CustomerService
//
//  Created by 单晨曦 on 2018/8/31.
//  Copyright © 2018年 吴宏佳. All rights reserved.
//

#import "detailsVC.h"
#import <BmobSDK/Bmob.h>

@interface detailsVC ()
@property (strong, nonatomic) NSMutableArray *datas;

@end

@implementation detailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

   
    

    self.datas = [NSMutableArray arrayWithArray:[self.newsObj.imgs componentsSeparatedByString:@","]];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count + 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellImgID = @"dsagsdgshctyh-img";
    static NSString* cellTextID = @"dsagsdgshctyh-text";
    static NSString* cellTitleID = @"dsagsdgshctyh-title";
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTitleID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTitleID];
            
            UILabel *titleLab = [[UILabel alloc]init];
            [cell.contentView addSubview:titleLab];
            titleLab.numberOfLines = 0;
            titleLab.font = [UIFont systemFontOfSize:20.f];
            titleLab.textColor = HJCOLOR3;

            UILabel *subtitleLab = [[UILabel alloc]init];
            [cell.contentView addSubview:subtitleLab];
            subtitleLab.numberOfLines = 0;
            subtitleLab.font = [UIFont systemFontOfSize:15.f];
            subtitleLab.textColor = HJCOLOR6;

            [titleLab makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(10.f);
                make.right.equalTo(-10.f);
            }];
            
            [subtitleLab makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(10.f);
                make.top.equalTo(titleLab.mas_bottom).offset(10.f);
                make.bottom.right.equalTo(-10.f);

            }];
            
            titleLab.text = self.newsObj.title;
            subtitleLab.text = self.newsObj.subtitle;
        }


        return cell;

    }else if (indexPath.row == self.datas.count+1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTextID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTextID];
            UILabel *textLab = [[UILabel alloc]init];
            [cell.contentView addSubview:textLab];
            textLab.numberOfLines = 0;
            [textLab makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(10.f);
                make.right.bottom.equalTo(-10.f);
            }];
            textLab.text = self.newsObj.text;

        }
        
        return cell;

    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellImgID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellImgID];
        }
        NSInteger tag = 1837;
        UIImageView *imgView = [cell.contentView viewWithTag:tag];
        if (!imgView) {
            imgView = [[UIImageView alloc]init];
            [cell.contentView addSubview:imgView];
            imgView.tag = tag;
            [imgView makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(10);
                make.bottom.right.equalTo(-10.f);
                make.height.equalTo(imgView.mas_width).multipliedBy(0.75);
            }];
            
        }
        [imgView sd_setImageWithURL:[NSURL URLWithString:self.datas[indexPath.row-1]]];
        
        return cell;
    }
   
}



@end

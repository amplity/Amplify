//
//  ZYWSideTableView.m
//  ZYWQQ
//
//  Created by Devil on 16/2/23.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "ZYWSideTableView.h"

@interface ZYWSideTableView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *arrayM;


@end

@implementation ZYWSideTableView
//    实例化
-(NSMutableArray *)arrayM{
    if (_arrayM==nil) {
        _arrayM=[NSMutableArray array];
    }
    return _arrayM;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    //    设置代理和数据源
    self.delegate=self;
    self.dataSource=self;
    
    self.rowHeight=50;
    
    self.separatorStyle=NO;
    return  self;
}



//实现数据源方法
-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.row==0) {
        cell.imageView.image=[UIImage imageNamed:@"sidebar_business"];
        cell.textLabel.text=@"我的商城";
    }else if (indexPath.row==1){
        cell.imageView.image=[UIImage imageNamed:@"sidebar_purse"];
        cell.textLabel.text=@"QQ钱包";
    }else if (indexPath.row==2){
        cell.imageView.image=[UIImage imageNamed:@"sidebar_decoration"];
        cell.textLabel.text=@"个性装扮";
    }else if (indexPath.row==3){
        cell.imageView.image=[UIImage imageNamed:@"sidebar_favorit"];
        cell.textLabel.text=@"我的收藏";
    }else if (indexPath.row==4){
        cell.imageView.image=[UIImage imageNamed:@"sidebar_album"];
        cell.textLabel.text=@"我的相册";
    }else{
        cell.imageView.image=[UIImage imageNamed:@"sidebar_file"];
        cell.textLabel.text=@"我的文件";
    }
    
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    //    点击cell时没有点击效果
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"jnkjn");
    
}
@end

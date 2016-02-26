//
//  ZYWSideView.m
//  ZYWQQ
//
//  Created by Devil on 16/2/23.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "ZYWSideView.h"
#import "ZYWSideTableView.h"


@interface ZYWSideView()<UIActionSheetDelegate>
@property(nonatomic,weak)UIView *blackView;

@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,copy)NSString *name;
@end



@implementation ZYWSideView

-(NSString *)name{
    if (_name==nil) {
        _name=@"跳转1";
    }
    
    return _name;
}

-(UIImageView *)headImage{
    if (_headImage==nil) {
        _headImage=[[UIImageView alloc]init];
    }
    return _headImage;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        //    按钮的frame
        CGFloat bX=30;
        CGFloat bY=100;
        CGFloat bW=270;
        CGFloat bH=60;
        //    在背景图上添加按钮
        UIButton *headBtn=[[UIButton alloc]initWithFrame:CGRectMake(bX,bY,bW,bH)];
        
        
        //    头像的frame
        CGFloat iX=0;
        CGFloat iY=0;
        CGFloat iW=headBtn.bounds.size.height;
        CGFloat iH=headBtn.bounds.size.height;
        //    在按钮上添加头像
        
        
        
        
        UIImageView *headImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"123"]];
      
        headImage.frame=CGRectMake(iX,iY,iW,iH);
        headImage.layer.cornerRadius =headBtn.bounds.size.height * 0.5;
        headImage.layer.masksToBounds = YES;
        
        
        
        
        //    名称的frame
        CGFloat lX=iW+10;
        CGFloat lY=iY;
        CGFloat lW=iW;
        CGFloat lH=iW*0.5;
        //    在按钮上显示名称
        UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(lX,lY,lW,lH)];
        headLabel.text=@"Devil";
        
        //     二维码的frame
        CGFloat qW=headBtn.bounds.size.height;
        CGFloat qH=headBtn.bounds.size.height;
        CGFloat qX=headBtn.bounds.size.width-qW;
        CGFloat qY=0;
        UIButton *qrCode=[[UIButton alloc]initWithFrame:CGRectMake(qX,qY,qW,qH)];
        [qrCode setImage:[UIImage imageNamed:@"sidebar_ QRcode_normal"] forState:UIControlStateNormal];
        
        //        创建透明view上的tableview
        ZYWSideTableView *sbv=[[ZYWSideTableView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height*0.4,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height*0.6-48)];
//
        sbv.backgroundColor=[UIColor clearColor];
        
        //  =======================
        //       创建底部view的按钮
        UIButton *setBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,0,48*2,48)];
        [setBtn setTitle:@"设置" forState:UIControlStateNormal];
        [setBtn setImage:[UIImage imageNamed:@"sidebar_setting"] forState:UIControlStateNormal];
        
//        [setBtn addTarget:self action:@selector(didSetBtn) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *dayBtn=[[UIButton alloc]initWithFrame:CGRectMake(48*2,0,48*2,48)];
        [dayBtn setTitle:@"夜间" forState:UIControlStateNormal];
        [dayBtn setImage:[UIImage imageNamed:@"sidebar_nightmode_on"] forState:UIControlStateNormal];
        
        //        创建透明view上的底部view
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height-48,[UIScreen mainScreen].bounds.size.width, 48)];
        footView.backgroundColor=[UIColor clearColor];
        
        [footView addSubview:setBtn];
        [footView addSubview:dayBtn];
        // =====================================
        
        [headBtn addSubview:qrCode];
        [headBtn addSubview:headLabel];
        [headBtn addSubview:headImage];
        
        //  =========================
        //    为按钮添加单击事件（更换头像）
        [headBtn addTarget:self action:@selector(changeHeaderImage) forControlEvents:UIControlEventTouchUpInside];
        
        // ===========================
        [self addSubview:headBtn];
        
        [self addSubview:sbv];
        [self addSubview:footView];
        
    }
    
    //    注册通知观察者（接受通知，将记录跳转界面的值从主控制器传过来）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(zhuchuanzuo:) name:@"主传左" object:nil];
    
    
    
    
    return  self ;
    
}
-(void)dealloc
{
    // 移除通知观察者.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"移除主传左通知对象");
}
//接受从主控制器传过来的值
-(void)zhuchuanzuo:(NSNotification *)notify{
    
    self.name=notify.object;
}
//点击了头像按钮（更换头像）
-(void)changeHeaderImage{
    
    
//    NSLog(@"acac");
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:self.name object:nil];
    
}

@end

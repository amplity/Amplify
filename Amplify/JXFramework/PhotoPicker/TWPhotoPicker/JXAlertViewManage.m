//
//  JXAlertViewManage.m
//  Amplify
//
//  Created by ZhangJixu on 16/5/26.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "JXAlertViewManage.h"
#import "TTTAttributedLabel.h"


static const int AlertWith = 120;
static const int AlertHeight = 120;

@implementation JXAlertViewManage


+(void)showViewWithAlert:(NSString*)title withInfo:(NSString*)info withStatus:(NSString*)status{
    //背景
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT)];
    bgView.backgroundColor = HexRGBAlpha(0x000000,0.1);
    
    //alertView
    UIView * alertView = [[UIView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WITH/2-AlertWith/2, MAIN_SCREEN_HIGHT/2-AlertHeight/2, AlertWith, AlertHeight)];
    [bgView addSubview:alertView];
    alertView.backgroundColor = HexRGBAlpha(0x252525, 0.9);
    
    //title
    UILabel * titLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, AlertWith, 30)];
    titLab.text = title;
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.textColor = [UIColor whiteColor];
    titLab.font = [UIFont systemFontOfSize:15];
    
    [alertView addSubview:titLab];
    
    
    //info
    UILabel * infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, AlertWith, AlertHeight-40)];
    infoLab.text = info;
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.textColor = [UIColor whiteColor];
    infoLab.numberOfLines = 0;
    infoLab.font = [UIFont systemFontOfSize:13];
    [alertView addSubview:infoLab];
    
    
    //添加到windows
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 animations:^{
            [bgView removeFromSuperview];
        }];
    });
    
    
    
}




+(void)showMessageWithAlert:(NSString*)info{
    //背景
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT)];
    bgView.backgroundColor = HexRGBAlpha(0x000000,0.1);
    
    //alertView
    UIView * alertView = [[UIView alloc] init];
    [bgView addSubview:alertView];
    alertView.backgroundColor = HexRGBAlpha(0x252525, 1.0);
    [alertView.layer setMasksToBounds:YES];
    [alertView.layer setCornerRadius:5.0];
    
    
    //info
    UILabel * infoLab = [[UILabel alloc] init];
    infoLab.text = info;
    infoLab.textAlignment = NSTextAlignmentCenter;
    infoLab.textColor = [UIColor whiteColor];
//    infoLab.numberOfLines = 0;
    infoLab.font = [UIFont systemFontOfSize:13];
    [alertView addSubview:infoLab];
    [infoLab sizeToFit];
    
    
    alertView.frame = CGRectMake(MAIN_SCREEN_WITH/2-(infoLab.bounds.size.width+50)/2, MAIN_SCREEN_HIGHT/2-infoLab.bounds.size.height, infoLab.bounds.size.width+50, infoLab.bounds.size.height*2);
    
    infoLab.frame = CGRectMake(25, infoLab.bounds.size.height/2, infoLab.bounds.size.width, infoLab.bounds.size.height);
    
    
    //添加到windows
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.0 animations:^{
            [bgView removeFromSuperview];
        }];
    });
}


@end

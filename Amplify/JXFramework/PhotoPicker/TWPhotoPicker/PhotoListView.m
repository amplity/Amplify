//
//  PhotoListView.m
//  Amplify
//
//  Created by ZhangJixu on 16/5/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "PhotoListView.h"
#import "PhotoModel.h"

@implementation PhotoListView

-(void)initBaseView:(BaseView *)baseView{
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT);
    
    baseView.backgroundColor = HexRGBAlpha(0x000000, 0.5);
    
    PhotoModel * photoModel = (PhotoModel*)self.baseViewModel;
    
    UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT-64)];
    scrollview.backgroundColor = [UIColor whiteColor];
    
    
    
    CGFloat viewHeight = 90;
    for (int i=0; i<photoModel.titleNames.count; i++) {
        
        
        UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight*i, MAIN_SCREEN_WITH, viewHeight)];
        
        UIImageView * photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 80 , 80)];
        photoImageView.image = [photoModel.images objectAtIndex:i];
        
        UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(photoImageView.bounds)+10+20, 0, 150, viewHeight)];
        nameLab.font = [UIFont systemFontOfSize:15];
        nameLab.textColor = [UIColor blackColor];
        nameLab.textAlignment = NSTextAlignmentLeft;
        [nameLab setText:[photoModel.titleNames objectAtIndex:i]];
        [bgView addSubview:nameLab];
        
        //分割线
        UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewHeight, MAIN_SCREEN_WITH, 1)];
        lineImageView.backgroundColor = HexRGBAlpha(0x000000, .3);
        [bgView addSubview:lineImageView];
        
        
        UILabel * numLab = [[UILabel alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WITH-100-20, 0, 100, viewHeight)];
        numLab.font = [UIFont systemFontOfSize:14];
        numLab.textColor = [UIColor lightGrayColor];
        numLab.textAlignment = NSTextAlignmentRight;
        [numLab setText:[photoModel.nums objectAtIndex:i]];
        [bgView addSubview:numLab];
        
        [bgView addSubview:photoImageView];
        
        
        // 点击按钮
        UIButton * clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, viewHeight)];
        clickBtn.tag = i;
        
        [clickBtn addTarget:self action:@selector(photoClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        

        [bgView addSubview:clickBtn];
        
        
        [scrollview addSubview:bgView];
    }
    
    CGFloat contentSizeHeight = viewHeight*photoModel.titleNames.count;
    scrollview.contentSize = CGSizeMake(MAIN_SCREEN_WITH, contentSizeHeight);
    [baseView addSubview:scrollview];
    
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    [bgView addGestureRecognizer:tap];
    
}

-(void)photoClickBtn:(id)sender{
    UIButton * btn = (UIButton*)sender;
    [self removeFromSuperview];
    [self baseViewClickToController:@"PhotoListViewClick" withObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
}





@end

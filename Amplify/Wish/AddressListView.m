//
//  AddressListView.m
//  Amplify
//
//  Created by ZhangJixu on 16/6/1.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "AddressListView.h"
#import "CacheAddressModel.h"
#import "AddressListModel.h"
#import "WishService.h"
#import "WishAndComModel.h"

@interface AddressListView (){
    NSString * wishId ;
    NSString * comId;
    NSString * addressId;
    
    
    
}

@end


@implementation AddressListView

-(void)initBaseView:(BaseView *)baseView{
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT);
    
    //获取地址
    [WishService getAddressList:^(id responseObj) {
        
        self.addressListModel = [AddressListModel mj_objectWithKeyValues:responseObj];
        
        [self initAddressListView:baseView];
        
    } withHandler:^(NSError *error) {
        
    }];
    
}

-(void)initAddressListView:(BaseView*)baseView{
    
    WishAndComModel * wishAndComModel = (WishAndComModel*)self.baseViewModel;
    wishId =wishAndComModel.wishId;
    comId = wishAndComModel.comId;
    
    baseView.backgroundColor = HexRGBAlpha(0x000000, 0.5);
    
    
    
    
    UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HIGHT-300, MAIN_SCREEN_WITH, 300)];
    scrollview.backgroundColor = HexRGB(0xECEBE8);
    
    //头部
    UILabel * headLab = [[UILabel alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HIGHT-300-40, MAIN_SCREEN_WITH, 40)];
    headLab.backgroundColor = HexRGB(0xECEBE8);
    headLab.text = @"地址选择";
    headLab.font = [UIFont systemFontOfSize:15];
    headLab.textColor = [UIColor blackColor];
    headLab.textAlignment = NSTextAlignmentCenter;
    headLab.textColor = HexRGBAlpha(0x7D122E,1.0);
    [baseView addSubview:headLab];
    
    //分割线
    UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, MAIN_SCREEN_HIGHT-300-1, MAIN_SCREEN_WITH, 1)];
    lineImageView.backgroundColor = HexRGBAlpha(0x000000, .3);
    [baseView addSubview:lineImageView];
    
    
   
    
    
    CGFloat viewHeight = 80;
    for (int i=0; i<self.addressListModel .responseBody.addrList.count; i++) {
        AddressListData * addressListData = [self.addressListModel .responseBody.addrList objectAtIndex:i];
        
        //姓名，电话
        NSString * addStr = [NSString stringWithFormat:@"%@     %@",addressListData.name,addressListData.phone];
        //省，市，区
        NSString * provinceAndCityAndCounty = [NSString stringWithFormat:@"%@ %@ %@%@",addressListData.provinceName,addressListData.cityName,addressListData.countyName,addressListData.address];
        
        
        UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeight*i, MAIN_SCREEN_WITH, viewHeight)];
        
        //姓名，电话
        UILabel * nameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH , viewHeight/2)];
        nameLab.font = [UIFont systemFontOfSize:14];
        nameLab.textColor = [UIColor blackColor];
        nameLab.textAlignment = NSTextAlignmentCenter;
        [nameLab setText:addStr];
        [bgView addSubview:nameLab];
        
        //地址
        UILabel * addressInfoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLab.bounds), MAIN_SCREEN_WITH , viewHeight/2)];
        addressInfoLab.font = [UIFont systemFontOfSize:14];
        addressInfoLab.textColor = [UIColor blackColor];
        addressInfoLab.textAlignment = NSTextAlignmentCenter;
        [addressInfoLab setText:provinceAndCityAndCounty];
        [bgView addSubview:addressInfoLab];
        
        //分割线
        UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, viewHeight, MAIN_SCREEN_WITH, 1)];
        lineImageView.backgroundColor = HexRGBAlpha(0x000000, .3);
        [bgView addSubview:lineImageView];
        
        
        
        //选中的
        
        if (self.addressListModel .responseBody.selectIndex == i) {
            UIImageView * selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WITH-60, 20, 20, 20)];
//            UIImage * selectImage = [UIImage imageNamed:@"iconfont-yuan"];
            selectImageView.layer.cornerRadius = 8;
            selectImageView.backgroundColor = HexRGB(0xB6A18C);
//            selectImageView.image = selectImage;
            
            [bgView addSubview:selectImageView];
        }
        
        
        
        
        // 点击按钮
        UIButton * clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, viewHeight)];
        clickBtn.tag = i;
        
        [clickBtn addTarget:self action:@selector(addListClickBtn:withObject:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [bgView addSubview:clickBtn];
        
        
        [scrollview addSubview:bgView];
    }
    
    
    CGFloat contentSizeHeight = 0;
    if (self.addressListModel .responseBody.addrList.count<=0) {
        //增加新增地址按钮
        UIButton * addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, viewHeight*(self.addressListModel .responseBody.addrList.count+1), MAIN_SCREEN_WITH, viewHeight)];
        [addBtn addTarget:self action:@selector(addClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setTitle:@"新增地址" forState:UIControlStateNormal];
        
        [scrollview addSubview:addBtn];
        contentSizeHeight = (viewHeight*self.addressListModel .responseBody.addrList.count+1);
    }else{
        contentSizeHeight = viewHeight*self.addressListModel .responseBody.addrList.count;
    }
    
    scrollview.contentSize = CGSizeMake(MAIN_SCREEN_WITH, contentSizeHeight);
    [baseView addSubview:scrollview];
    
    //取消
    UIButton * cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WITH-40, MAIN_SCREEN_HIGHT-CGRectGetMaxY(headLab.bounds)-CGRectGetMaxY(scrollview.bounds)-15, 31, 31)];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"wishCloseBtn"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(canceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:cancleBtn];
    
}

//新增地址
-(void)addClickBtn:(id)sender{
    UIButton * btn = (UIButton*)sender;
    [self removeFromSuperview];
    
    [self baseViewClickToController:@"addBtnClick" withObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
}


//地址选择
-(void)addListClickBtn:(id)sender withObject:(NSObject*)obj{
    UIButton * btn = (UIButton*)sender;
    
    
    AddressListData * addDate = [self.addressListModel.responseBody.addrList objectAtIndex:btn.tag];
    
    CacheAddressModel * cacheModel = [[CacheAddressModel alloc] init];
    cacheModel.phone = addDate.phone;
    cacheModel.name = addDate.name;
    cacheModel.provincesStr = [NSString stringWithFormat:@"%@%@%@",addDate.provinceName,addDate.cityName,addDate.countyName];//合并后
    cacheModel.addressInfo = addDate.countyName;
    cacheModel.addressNum = addDate.email;
    cacheModel.regionCode = addDate.county;
    cacheModel.wishId = wishId;
    cacheModel.comId = comId;
    cacheModel.addressId = addDate.addressId;
    cacheModel.address = addDate.address;
    cacheModel.addressNum = addDate.email;
    [self baseViewClickToController:@"addressListViewClick" withObject:cacheModel];
    
    [self removeFromSuperview];
}

//取消
-(void)canceBtnClick:(id)sender{
    [self removeFromSuperview];
    
}

@end

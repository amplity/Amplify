//
//  AddressConfirmView.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/1.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "AddressConfirmView.h"
#import "CacheAddressModel.h"
#import "WishService.h"
#import "AddressNewModel.h"
#import "AddNewAddressView.h"

@implementation AddressConfirmView

-(void)initBaseView:(BaseView*)baseView{
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT);
    
    
    if (self.baseViewModel) {
        CacheAddressModel * cacheAddressModel = (CacheAddressModel*)self.baseViewModel;
        
        self.phoneLab.text = cacheAddressModel.phone;
        
        self.addressInfo.text = cacheAddressModel.provincesStr;
        self.nameLab.text = cacheAddressModel.name;
        self.numLab.text = cacheAddressModel.regionCode;
        self.addressInfo2.text = cacheAddressModel.address;
        
        
    }
    
    self.editBtn.hidden = YES;
    
}

- (IBAction)okBtnClick:(id)sender {
    
    CacheAddressModel * cacheAddressModel = (CacheAddressModel*)self.baseViewModel;
    [WishService addNewAddressForWish:cacheAddressModel.name withPhone:cacheAddressModel.phone withAddress:cacheAddressModel.addressInfo withRegioncode:cacheAddressModel.regionCode withWishId:cacheAddressModel.wishId withComId:cacheAddressModel.comId withAddressId:cacheAddressModel.addressId withHandler:^(id responseObj) {
        AddressNewModel * addressNewModel = [AddressNewModel mj_objectWithKeyValues:responseObj];
        
        
        if ([addressNewModel.responseHead.code isEqualToString:@"00000"]) {
            
            
            [self baseViewClickToController:@"wishAddressConfirmViewOkBtnClick" withObject:addressNewModel];
            [self removeFromSuperview];
        }else{
            [JXAlertViewManage showViewWithAlert:@"" withInfo:addressNewModel.responseHead.msg withStatus:@""];
        }
        
    } withHandler:^(NSError *error) {
        
    }];
}

- (IBAction)closeBtnClick:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)editBtnClick:(id)sender {
    [self removeFromSuperview];
    
    
    //传人的是CacheAddressModel
//    [self baseViewClickToController:@"wishEditBtnClick" withObject:self.baseViewModel];
}

@end

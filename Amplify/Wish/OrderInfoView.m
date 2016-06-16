//
//  OrderInfoView.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/1.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "OrderInfoView.h"
#import "AddressNewModel.h"


@implementation OrderInfoView

-(void)initBaseView:(BaseView*)baseView{
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT);
    
    
    if (self.baseViewModel) {
        
        AddressNewModel * addressNewModel = (AddressNewModel*)(self.baseViewModel);
        self.orderInfoLab.text = [NSString stringWithFormat:@"%@%@",@"订单号:",addressNewModel.responseBody.orderId];
    }
    
}

- (IBAction)closeBtnClick:(id)sender {
    
    [self removeFromSuperview];
}
- (IBAction)nextBtnClick:(id)sender {
    
    [self baseViewClickToController:@"OrderInfoViewNextClick" withObject:nil];
    [self removeFromSuperview];
    
}
@end

//
//  AddressConfirmView.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/1.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseView.h"

@interface AddressConfirmView : BaseView
- (IBAction)okBtnClick:(id)sender;
- (IBAction)closeBtnClick:(id)sender;
- (IBAction)editBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *addressInfo;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *addressInfo2;

@end

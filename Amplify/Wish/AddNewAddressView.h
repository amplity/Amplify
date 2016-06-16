//
//  AddNewAddressView.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseView.h"

@interface AddNewAddressView : BaseView<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *personLab;


@property (weak, nonatomic) IBOutlet UITextField *personTxt;

@property (weak, nonatomic) IBOutlet UITextField *phoneTxt;

@property (weak, nonatomic) IBOutlet UILabel *shengLab;


@property (weak, nonatomic) IBOutlet UITextField *jieTxt;

@property (weak, nonatomic) IBOutlet UITextField *youTxt;

@property (weak, nonatomic) IBOutlet UIView *pickerViewBg;

@property (weak, nonatomic) IBOutlet UIView *addressInfoView;

- (IBAction)viewCloseClick:(id)sender;

- (IBAction)okBtnClick:(id)sender;

- (IBAction)closePickClick:(id)sender;
- (IBAction)finishBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerViewBgBot;

- (IBAction)shenBtnClick:(id)sender;


@end

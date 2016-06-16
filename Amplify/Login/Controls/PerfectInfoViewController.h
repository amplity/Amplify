//
//  PerfectInfoViewController.h
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/17.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "LoginMainViewController.h"

@interface PerfectInfoViewController : LoginMainViewController
//消失或者调用diss后需要重新显示的view，用于刷新viewcontroller
@property (nonatomic, strong) BaseViewController *dissViewController;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UITextField *phoneTxt;
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (weak, nonatomic) IBOutlet UITextField *codeTxt;
- (IBAction)codeBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
- (IBAction)changeBtnClick:(id)sender;
- (IBAction)infoBtnClick:(id)sender;
- (IBAction)successBtn:(id)sender;


//注册
//绑定
- (IBAction)zhuAndBindBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *zhuceBtn;
@property (weak, nonatomic) IBOutlet UIButton *bindHeadBtn;



//------绑定已有账户------

@property (weak, nonatomic) IBOutlet UITextField *bindNameLab;

@property (weak, nonatomic) IBOutlet UITextField *bindPasswordText;
- (IBAction)forgetBtnClick:(id)sender;

- (IBAction)bindLoginBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *bindUseView;
@property (weak, nonatomic) IBOutlet UIView *regiNewUseView;

@end

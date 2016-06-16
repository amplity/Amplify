//
//  RegiserViewController.h
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/1.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "LoginMainViewController.h"

@interface RegiserViewController : LoginMainViewController<UITextFieldDelegate,UITextViewDelegate>

//消失或者调用diss后需要重新显示的view，用于刷新viewcontroller
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *codeView;

//验证码
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UIButton *regiserTagBtn;
- (IBAction)regiserTagBtnClick:(id)sender;

- (IBAction)regiserInfoBtnClick:(id)sender;

//注册
@property (weak, nonatomic) IBOutlet UIButton *regiserBtn;




@property (nonatomic, strong) BaseViewController *dissViewController;
@end

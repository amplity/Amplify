//
//  LoginViewController.h
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/1.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "LoginMainViewController.h"

@interface LoginViewController : LoginMainViewController<UITextFieldDelegate>


/**
 *  消失或者调用diss后需要重新显示的view，用于刷新viewcontroller(因来源不同，故需要记录，有可能是上一个界面，也有可能是上一个界面点击后的界面)
 */
@property (nonatomic, strong) BaseViewController *dissViewController;
@property (weak, nonatomic) IBOutlet UIView *phoneText;
@property (weak, nonatomic) IBOutlet UIView *passwordText;

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *weiboLoginLab;
@property (weak, nonatomic) IBOutlet UIButton *weiboLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginBtn;
@property (weak, nonatomic) IBOutlet UILabel *wxLoginLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sinaBtnLayoutTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sinaLabLayoutTrailing;

- (IBAction)goLogin:(id)sender;

- (IBAction)goSignUp:(id)sender;
- (IBAction)goWx:(id)sender;
- (IBAction)goSinaWeibo:(id)sender;
- (IBAction)goFindPwdBack:(id)sender;

@end

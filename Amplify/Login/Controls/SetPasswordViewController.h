//
//  SetPasswordViewController.h
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/1.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "LoginMainViewController.h"

@interface SetPasswordViewController : LoginMainViewController

//消失或者调用diss后需要重新显示的view，用于刷新viewcontroller
@property (nonatomic, strong) BaseViewController *dissViewController;
@property (strong, nonatomic)  NSString *phoneNum;
@property (weak, nonatomic) IBOutlet UIView *passwordConfirm;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmTF;

@property (weak, nonatomic) IBOutlet UIButton *regiserOkBtn;


@property (weak, nonatomic) IBOutlet UIView *phoneView;


@end

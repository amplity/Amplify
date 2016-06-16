//
//  ForgetPasswordViewController.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/1.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "LoginService.h"
#import "SetPasswordViewController.h"

@interface ForgetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *smsCode;
@property (nonatomic) BOOL isSuccessSend;
@end

@implementation ForgetPasswordViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = ColorWithHexAlpha(0XFFFFFF, 1.0);
    
//    self.titleLabTxt.text = @"找回密码";
//    self.titleHeadView.backgroundColor = ColorWithHexAlpha(0X282829, 1.0);
//    self.titleLabTxt.textColor = [UIColor whiteColor];
//    [self.cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.navigationItem.title = @"找回密码";;
    
    self.isSuccessSend = NO;
    
}

- (IBAction)getSMSCode
{
    if ([self.phoneNum.text length] == 0) {
        
        [TipManager showTipsWithInforStr:@"手机号码不能为空" withAfter:1.0];
        
        return;
    }
    
    
    if (self.phoneNum.text.length == 11) {
        
        NSString *phoneNum = self.phoneNum.text;
        
        [LoginService sendSMSCodeForResetPwd:phoneNum withHandler:^(id responseObj) {
            NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
            NSString *code = [responseHead objectForKey:@"code"];
            if ([code isEqualToString:@"00000"]) {
                
                self.isSuccessSend = YES;
                
                [self startTime];
                
            } else {
                NSString *msg = [responseHead objectForKey:@"msg"];
                
                [TipManager showTipsWithInforStr:msg withAfter:1.0];
            }

        } withRequestFailBlock:^(NSError *error) {
            
        }];
    }else{
        [TipManager showTipsWithInforStr:@"手机号码不正确" withAfter:1.0];
    }
}

- (IBAction)goSubmit {
    
    
    if ([self.phoneNum.text length] == 0) {
        
        [TipManager showTipsWithInforStr:@"手机号码不能为空" withAfter:1.0];
        return;
    }
    
    
    if (self.smsCode.text.length == 6 && self.isSuccessSend) {
//        NSString *encryptCheckCode = [AESCrypt encrypt:self.smsCode.text password:PrivateKey];//前端暂时不加密
        
        
        [LoginService checkSmsCode:self.phoneNum.text withSmsCode:self.smsCode.text withHandler:^(id responseObj) {
            NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
            NSString *code = [responseHead objectForKey:@"code"];
            if ([code isEqualToString:@"00000"]) {
                
                DLog(@"success");
                
                
                //                    UIStoryboard *board=[UIStoryboard storyboardWithName:@"iPhone" bundle:Nil];
                SetPasswordViewController *setPwdVC= [[SetPasswordViewController alloc] init];
                setPwdVC.phoneNum = self.phoneNum.text;
                
                [self.navigationController pushViewController:setPwdVC animated:YES];
                
            } else {
                NSString *msg = [responseHead objectForKey:@"msg"];
                
                [TipManager showTipsWithInforStr:msg withAfter:1.0];
            }

        } withRequestFailBlock:^(NSError *error) {
            
        }];
    }
    
}


-(void)startTime{
    __block int timeout=180; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 180;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.codeBtn setTitle:[NSString stringWithFormat:@"重新发送%@",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.codeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.phoneView.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }];
    
    [self.codeView.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }];
}

@end

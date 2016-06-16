//
//  RegiserViewController.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/1.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "RegiserViewController.h"
#import "LoginService.h"
#import "BindCommandViewController.h"
#import "SetPasswordViewController.h"

#import "UserManager.h"

@interface RegiserViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;

@property (weak, nonatomic) IBOutlet UITextField *checkCodeTF;
@property (weak, nonatomic) IBOutlet UIButton    *getCodeBT;
@property (nonatomic) BOOL isSuccessSend;

//倒计时
@property (nonatomic, assign) int lefeTime;

@end

@implementation RegiserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"手机快速注册";
    
    self.isSuccessSend = NO;
    
    
    [self.phoneNumTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self.checkCodeTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
    //设置圆角
    [self.codeBtn.layer setMasksToBounds:YES];
    [self.codeBtn.layer setCornerRadius:2.0];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setRegiserCodeBtnStatus];
    [self setRegiserBtnStatus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendSMSCode:(UIButton *)sender
{
    if (self.phoneNumTF.text.length == 11) {
        
        [LoginService sendSMSCode:self.phoneNumTF.text withHandler:^(id responseObj) {
            
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
        
    } else {
        
        if (self.phoneNumTF.text.length != 11) {
            
            NSString * msg = [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"手机号 %@",self.phoneNumTF.text],@"格式有误"];
            [TipManager showTipsWithInforStr:msg withAfter:1.0];
        }
    }
    
}


-(void)startTime{
    __block int timeout=180; //倒计时时间
    _lefeTime = 180;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            _lefeTime = 0;
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.codeBtn.userInteractionEnabled = YES;
                [self setRegiserCodeBtnStatus];
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
            _lefeTime--;
        }
    });
    dispatch_resume(_timer);
    
    [self setRegiserCodeBtnStatus];
}



- (IBAction)submitCheckCode:(UIButton *)sender
{
    
    if (self.checkCodeTF.text.length == 6 && self.isSuccessSend == YES){
        
        [LoginService submitCheckCode:self.phoneNumTF.text withSmsCode:self.checkCodeTF.text withHandler:^(id responseObj) {
            NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
            NSString *code = [responseHead objectForKey:@"code"];
            if ([code isEqualToString:@"00000"]) {
                
                
                SetPasswordViewController * setPasswordViewController = [[SetPasswordViewController alloc] init];
                setPasswordViewController.phoneNum = self.phoneNumTF.text;
                setPasswordViewController.inputViewData = @"2";
                [self.navigationController pushViewController:setPasswordViewController animated:YES];
                
            } else {
                
                NSString *msg = [responseHead objectForKey:@"msg"];
                [TipManager showTipsWithInforStr:msg withAfter:1.0];
            }

            
        } withRequestFailBlock:^(NSError *error) {
            
        }];
        
    } else {
        [TipManager showTipsWithInforStr:@"验证码应该是6位" withAfter:1.0];
    }
}


//设置获得注册码按钮状态
-(void)setRegiserCodeBtnStatus{
    //手机号
    
    //时间
    
    if (self.phoneNumTF.text.length ==11 && _lefeTime==0) {
        self.codeBtn.backgroundColor = HexRGB(0xB6A18C);
        self.codeBtn.titleLabel.textColor = HexRGB(0xffffff);
        self.codeBtn.selected = YES;
    }else{
        self.codeBtn.backgroundColor = HexRGB(0xd4d4d4);
        self.codeBtn.titleLabel.textColor = HexRGB(0xB8B8B8);
        self.codeBtn.selected = NO;
    }
}

//设置注册按钮的状态
-(void)setRegiserBtnStatus{
    //手机号
    //验证码
    //注册协议
    
    if (self.phoneNumTF.text.length == 11 && self.checkCodeTF.text.length == 6 && self.regiserTagBtn.selected) {
        self.regiserBtn.backgroundColor = HexRGB(0x252525);
        self.regiserBtn.titleLabel.textColor = HexRGB(0xffffff);
        self.regiserBtn.selected = NO;
        self.regiserBtn.userInteractionEnabled = YES;
    }else{
        self.regiserBtn.backgroundColor = HexRGB(0xd4d4d4);
        self.regiserBtn.titleLabel.textColor = HexRGB(0xB8B8B8);
        self.regiserBtn.selected = YES;
        self.regiserBtn.userInteractionEnabled = NO;
    }
}

-(void)textFieldChanged{
    
    if (self.phoneNumTF.isFirstResponder) {
        [self setRegiserCodeBtnStatus];
        [self setRegiserBtnStatus];
    }
    
    if (self.checkCodeTF.isFirstResponder) {
        [self setRegiserBtnStatus];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (self.phoneNumTF.isFirstResponder) {
        [self.phoneNumTF resignFirstResponder];
    }
    
    if (self.checkCodeTF.isFirstResponder) {
        [self.checkCodeTF resignFirstResponder];
    }
    
    return YES;
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

- (IBAction)regiserTagBtnClick:(id)sender {
    
    self.regiserTagBtn.selected = !self.regiserTagBtn.selected;
    
    
    [self setRegiserBtnStatus];
}

- (IBAction)regiserInfoBtnClick:(id)sender {
    
    self.regiserTagBtn.selected = YES;//看完必定选中
    //注册信息
    BindCommandViewController * bindCommandViewController = [[BindCommandViewController alloc] init];
    [self.navigationController pushViewController:bindCommandViewController animated:YES];
}
@end

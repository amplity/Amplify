//
//  SetPasswordViewController.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/1.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "SetPasswordViewController.h"
#import "LoginService.h"
#import "TipManager.h"

@interface SetPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *password;
@end

@implementation SetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title  =@"设置密码";
    
    [self.password addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
    [self.passwordConfirmTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goChangePwd
{
    if (self.password.text.length < 6 ){
        
        [TipManager showTipsWithInforStr:@"请设置密码大于6位" withAfter:1.0];
        
        
        return;
    }
    
    
    if (![self.password.text isEqualToString:self.passwordConfirmTF.text]) {
        [TipManager showTipsWithInforStr:@"两次密码不一致" withAfter:1.0];
        
        return;
    }
    
    if (self.password.text.length >= 6 ){
        
        if (self.inputViewData && [self.inputViewData isEqualToString:@"2"]) {//注册设置密码
            [LoginService regiserResetPassword:self.phoneNum withPassword:self.password.text withHandler:^(id responseObj) {
                NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
                NSDictionary * responseBody = [responseObj objectForKey:@"responseBody"];
                NSString *code = [responseHead objectForKey:@"code"];
                if ([code isEqualToString:@"00000"]) {
                    [self saveLoginInfo:responseHead withResponseBody:responseBody];
                }
                
            } withRequestFailBlock:^(NSError *error) {
                [TipManager showTipsWithInforStr:error.domain withAfter:1.0];
            }];
        }else{
            [LoginService resetPassword:self.phoneNum withPassword:self.password.text withHandler:^(id responseObj) {
                NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
                NSDictionary * responseBody = [responseObj objectForKey:@"responseBody"];
                NSString *code = [responseHead objectForKey:@"code"];
                if ([code isEqualToString:@"00000"]) {
                    [self saveLoginInfo:responseHead withResponseBody:responseBody];
                }
                
            } withRequestFailBlock:^(NSError *error) {
                [TipManager showTipsWithInforStr:error.domain withAfter:1.0];
            }];
        }
    }
    
}

//保存登录信息
-(void)saveLoginInfo:(NSDictionary*)responseHead withResponseBody:(NSDictionary*)responseBody{
    [UserManager saveLogin];
    [UserManager saveToken:[responseHead objectForKey:@"token"]];
    
    
    //心愿通知 (向后端传递regiid）
    
    if([UserManager JPushRegistrationId]){
        [LoginService jPushRegistrationId:[UserManager JPushRegistrationId] withdeviceId:[UserManager deviceId] withHandler:^(id responseObj) {
            NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
            if ([[responseHead objectForKey:@"code"] isEqualToString:@"00000"]) {
                DLog(@"给后端发送RegistrationId成功");
            }
        } withHandler:^(NSError *error) {
            
        }];
    }
    
    
    
    
    
    //保存是否被邀请了
    NSString *haveWishId =[responseBody objectForKey:@"haveWish"];
    BOOL haveWish = haveWishId.intValue == 1 ? YES : NO;
    
    if (haveWish &&![UserManager firstInviteWish]) {
        [UserManager saveFirstInviteWish:YES];
    }
    [UserManager saveInviteWish:haveWish];
    
    //---------------------返回到出掉登录的页面-------------------
    
    NSMutableArray * array =[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    BaseViewController * navViewCon;
    for (navViewCon in array) {
        if (![navViewCon isKindOfClass:NSClassFromString(@"LoginMainViewController")]) {
            break;
        }
    }
    
    [self.navigationController popToViewController:navViewCon animated:YES];
    
    //-------------------------------End-------------------------
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setRegiserBtnStatus];
}

-(void)textFieldChanged{
    
    if (self.password.isFirstResponder) {
        [self setRegiserBtnStatus];
    }
    
    if (self.passwordConfirmTF.isFirstResponder) {
        [self setRegiserBtnStatus];
    }
}

//设置注册按钮的状态
-(void)setRegiserBtnStatus{
    //俩次密码一致


    
    if (self.password.text.length ==self.passwordConfirmTF.text.length) {
        self.regiserOkBtn.backgroundColor = HexRGB(0x252525);
        self.regiserOkBtn.titleLabel.textColor = HexRGB(0xffffff);
        self.regiserOkBtn.selected = YES;
        self.regiserOkBtn.userInteractionEnabled = YES;
    }else{
        self.regiserOkBtn.backgroundColor = HexRGB(0xd4d4d4);
        self.regiserOkBtn.titleLabel.textColor = HexRGB(0xB8B8B8);
        self.regiserOkBtn.selected = NO;
        self.regiserOkBtn.userInteractionEnabled = NO;
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phoneView.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }];
    
    [self.passwordConfirm.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }];
}

@end

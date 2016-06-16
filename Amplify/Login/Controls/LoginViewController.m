//
//  LoginViewController.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/1.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "LoginViewController.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import "LoginService.h"
#import "UserManager.h"
#import "ForgetPasswordViewController.h"
#import "RegiserViewController.h"
#import "SetPasswordViewController.h"
#import "ThridPartManager.h"
#import "UIScrollView+touch.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"登录";
    
    
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_tool"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClick)];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
}

-(void)leftClick{
    
    [self.navigationController popViewControllerAnimated:NO];
    [self.loginRestltDelegate showLoginResult:NO withClickStr:self.beforeOptionStr];
    
    
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


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.delegate =nil;
    
    
    if (![WXApi isWXAppInstalled]){
        self.wxLoginBtn.hidden = YES;
        self.wxLoginLab.hidden = YES;
        
        self.sinaBtnLayoutTrailing.constant = MAIN_SCREEN_WITH/2-50/2;
        self.sinaLabLayoutTrailing.constant = MAIN_SCREEN_WITH/2-120/2;

    }else{
        self.sinaBtnLayoutTrailing.constant = 70;
        self.sinaLabLayoutTrailing.constant = 35;
    }
}


- (IBAction)goLogin:(UIButton *)sender
{
    
    
    [self.password resignFirstResponder];
    
    
    if ([self.username.text length] == 0) {
        
        [TipManager showTipsWithInforStr:@"手机号码不能为空" withAfter:1.0];
        return;
    }
    
    if ([self.username.text length] != 11) {
        
        [TipManager showTipsWithInforStr:@"手机号码格式有误" withAfter:1.0];
        
        return;
    }
    
    
    if ([self.password.text length] == 0) {
        [TipManager showTipsWithInforStr:@"密码不能为空" withAfter:1.0];
        
        return;
    }
    
    
    
    
    [LoginService authentication:self.username.text withPassword:self.password.text withSmsCode:@"" withHandler:^(id responseObj) {
        
        NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
        NSDictionary * responseBody = [responseObj objectForKey:@"responseBody"];
        NSString *code = [responseHead objectForKey:@"code"];
        if ([code isEqualToString:@"00000"]) {
            
            
            NSDictionary *userInfo = [responseBody objectForKey:@"account"];
            
            // Set is login and save to userManger must be togother.
            [UserManager saveLogin];
            [UserManager saveToken:[responseHead objectForKey:@"token"]];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [self.loginRestltDelegate showLoginResult:YES withClickStr:self.beforeOptionStr];
            
            
            
            
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
            
            
            
        } else {
            NSString *msg = [responseHead objectForKey:@"msg"];
            [TipManager showTipsWithInforStr:msg withAfter:1.0];
        }

    } withRequestFailBlock:^(NSError *error) {
        
    }];
    
}

- (IBAction)goSignUp:(UIButton *)sender
{
    RegiserViewController * regiserViewController = [[RegiserViewController alloc] init];
    
    [self.navigationController pushViewController:regiserViewController animated:YES];
}

- (IBAction)goFindPwdBack:(UIButton *)sender
{
    ForgetPasswordViewController * forgetPasswordViewController = [[ForgetPasswordViewController alloc] init];
    
    [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
    
}

- (IBAction)goSinaWeibo:(UIButton *)sender
{
    
//    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    request.redirectURI = @"http://";
//    request.scope = @"all";
////    request.redirectURI = @"http://www.sina.com";
////    request.scope = @"all";
////    request.userInfo = @{@"SSO_From": @"LoginViewController"};
//    [WeiboSDK sendRequest:request];
    
    [[ThridPartManager manager] weiboLogin:self.dissViewController withPresentViewController:self];
    
}


- (IBAction)goWx:(UIButton *)sender
{
//    SendAuthReq *auth = [[SendAuthReq alloc] init];
//    auth.scope = @"snsapi_userinfo";
//    auth.state = @"201014";
//    [WXApi sendReq:auth];
    
    [[ThridPartManager manager] weixinLogin:self.dissViewController withPresentViewController:self];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.password resignFirstResponder];
    
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.phoneText.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }];
    
    [self.passwordText.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UITextField class]]) {
            [obj resignFirstResponder];
        }
    }];
}

@end

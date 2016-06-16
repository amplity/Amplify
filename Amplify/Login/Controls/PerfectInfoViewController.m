//
//  PerfectInfoViewController.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/17.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "PerfectInfoViewController.h"
#import "LoginService.h"
#import "ForgetPasswordViewController.h"
#import "LoginBind.h"
#import "UIImageView+WebCache.h"
#import "BindCommandViewController.h"
#import "UserManager.h"

@interface PerfectInfoViewController (){
    
    //选中阅读
    BOOL changeBtnSelected;
    
}

@end

@implementation PerfectInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"完善信息";
    
    [self setViewRigShow:0];
//    self.changTabBar.selectedItem = [self.changTabBar.items objectAtIndex:0];
    [self setBindAndZhuceBtnStatus:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setViewRigShow:(NSInteger)tag{
    [self.view endEditing:YES];
    if(tag==0){
        self.bindUseView.hidden = YES;
        self.regiNewUseView.hidden = NO;
    }else{
        self.bindUseView.hidden = NO;
        self.regiNewUseView.hidden = YES;
    }
    
    [self setBoardUIInfo:tag];
}

//设置面板信息
-(void)setBoardUIInfo:(NSInteger)tag{
    LoginBind *loginBind = self.inputViewData;
    if(tag ==0){
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:loginBind.profileUrl]];
        self.nameLab.text = loginBind.nickname;
    }else{
        
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)codeBtnClick:(id)sender {
    
    //获取验证码
    if (self.phoneTxt.text.length == 11) {
        
        [LoginService sendSMSCode:self.phoneTxt.text withHandler:^(id responseObj) {
            NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
            NSString *code = [responseHead objectForKey:@"code"];
            if ([code isEqualToString:@"00000"]) {
                //                    self.isSuccessSend = YES;
                
                [self startTime];
            } else {
                NSString *msg = [responseHead objectForKey:@"msg"];
                [TipManager showTipsWithInforStr:msg withAfter:1.0];
            }
        } withRequestFailBlock:^(NSError *error) {
        }];
        
    } else {
        
        if (self.phoneTxt.text.length != 11) {
            
            NSString * msg = [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"手机号 %@",self.phoneTxt.text],@"格式有误"];
            [TipManager showTipsWithInforStr:msg withAfter:1.0];
            
        }
    }
}


//勾选
- (IBAction)changeBtnClick:(id)sender {
    changeBtnSelected = !changeBtnSelected;
    self.changeBtn.selected = changeBtnSelected;
}


//阅读
- (IBAction)infoBtnClick:(id)sender {
    
    changeBtnSelected = YES;
    self.changeBtn.selected = YES;
    //去阅读Url
    
    BindCommandViewController * bindCommandViewController = [[BindCommandViewController alloc] init];
    
    [self.navigationController pushViewController:bindCommandViewController animated:YES];
}

//绑定
- (IBAction)successBtn:(id)sender {
    
    if ([self.phoneTxt.text length] == 0) {
        
        
        [TipManager showTipsWithInforStr:@"手机号码不能为空" withAfter:1.0];
        return;
    }
    
    if ([self.phoneTxt.text length] != 11) {
        
        
        [TipManager showTipsWithInforStr:@"手机号码格式有误" withAfter:1.0];
        return;
    }
    
    
    if ([self.codeTxt.text length] == 0) {
        
        [TipManager showTipsWithInforStr:@"验证码不能为空" withAfter:1.0];
        return;
    }
    
    if ([self.codeTxt.text length] != 6) {
        [TipManager showTipsWithInforStr:@"验证码格式错误" withAfter:1.0];
        
        return;
    }
    
    //绑定
    if(!self.changeBtn.selected){
        [TipManager showTipsWithInforStr:@"请阅读条例" withAfter:1.0];
        return;
    }
    
    LoginBind *loginBind = self.inputViewData;
    
    [LoginService weiboAndWeiXiBindForAccount:loginBind.uid withProfileUrl:loginBind.profileUrl withGender:loginBind.gender withUnionId:loginBind.unionId  withMsCode:self.codeTxt.text withPhone:self.phoneTxt.text withDisplayName:loginBind.nickname withThirdPlatform:loginBind.thirdPlatform withHandler:^(id responseObj) {
        NSDictionary * responseHead =[responseObj objectForKey:@"responseHead"];
        NSDictionary * responseBody = [responseObj objectForKey:@"responseBody"];
        if([[responseHead objectForKey:@"code"] isEqualToString:@"00000"]){
            [UserManager saveLogin];
            [UserManager saveToken:[responseHead objectForKey:@"token"]];
            
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
            
        }else{
            [TipManager showTipsWithInforStr:[responseHead objectForKey:@"msg"] withAfter:1.0];
        }

    } withRequestFailBlock:^(NSError *error) {
        
    }];
    
}
- (IBAction)forgetBtnClick:(id)sender {
    
    ForgetPasswordViewController * forgetPasswordViewController = [[ForgetPasswordViewController alloc] init];
    
    [self.navigationController pushViewController:forgetPasswordViewController animated:YES];
}

- (IBAction)bindLoginBtnClick:(id)sender {
    if ([self.bindNameLab.text length] == 0) {
        
        [TipManager showTipsWithInforStr:@"手机号码不能为空" withAfter:1.0];
        return;
    }
    
    if ([self.bindNameLab.text length] != 11) {
        
        [TipManager showTipsWithInforStr:@"手机号码格式有误" withAfter:1.0];
        return;
    }
    
    
    if ([self.bindPasswordText.text length] == 0) {
        
        
        [TipManager showTipsWithInforStr:@"密码不能为空" withAfter:1.0];
        
        return;
    }
    
    LoginBind *loginBind = self.inputViewData;
    
    [LoginService weiboAndWeixiBind:loginBind.uid withPhone:self.bindNameLab.text withPassword:self.bindPasswordText.text withGender:loginBind.gender withThirdPlatform:loginBind.thirdPlatform withUnionId:loginBind.unionId withDisplayName:loginBind.nickname withHandler:^(id responseObj) {
        
        NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
        NSDictionary * responseBody = [responseObj objectForKey:@"responseBody"];
        if([[responseHead objectForKey:@"code"] isEqualToString:@"00000"]){
            
            [UserManager saveLogin];
            [UserManager saveToken:[responseHead objectForKey:@"token"]];
            
            
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
            
            
        }else{
            [TipManager showTipsWithInforStr:[responseHead objectForKey:@"msg"] withAfter:1.0];
        }
    } withRequestFailBlock:^(NSError *error) {
        
    }];
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



/**
 *  选中的背景
 *
 *  @param selectIndex 选中那个button
 */
-(void)setBindAndZhuceBtnStatus:(int)selectIndex{
    switch (selectIndex) {
        case 0:
            self.zhuceBtn.backgroundColor = HexRGB(0xB6A18C);
            self.bindHeadBtn.backgroundColor = HexRGB(0x252525);
            break;
        case 1:
            self.zhuceBtn.backgroundColor = HexRGB(0x252525);
            self.bindHeadBtn.backgroundColor = HexRGB(0xB6A18C);
            break;
            
        default:
            break;
    }
}


- (IBAction)zhuAndBindBtnClick:(id)sender {
    UIButton * currentBtn = (UIButton*)sender;
    
    [self setViewRigShow:currentBtn.tag];
    [self setBindAndZhuceBtnStatus:(int)currentBtn.tag];
}
@end

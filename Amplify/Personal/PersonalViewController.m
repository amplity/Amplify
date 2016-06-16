//
//  PersonalViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "PersonalViewController.h"
#import "LoginViewController.h"
#import "PersonalInfoViewController.h"
#import "BaseWebManager.h"
#import "PersonalUrlModel.h"
#import "HomTabBarController.h"
#import "SettingViewController.h"
#import "LinkModel.h"
#import "DiscoverInfoViewController.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.automaticallyAdjustsScrollViewInsets = NO;//    自动滚动调整，默认为YES

}



-(void)initLoginStatus{
    
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:[NSString stringWithFormat:@"%@?token=%@",@"/api/app/member/myAccount",[UserManager token]] withParameter:nil];
    if([UserManager isLogin]){
        [self.baseWebView baseLoadRequest:comUrl];
    }else{
        
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            LoginViewController * loginViewController = [[LoginViewController alloc] init];
            loginViewController.loginRestltDelegate = weakSelf;
            [weakSelf.navigationController pushViewController:loginViewController animated:YES];
        });
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
//    if( self.view.window == nil && [self isViewLoaded]) {
//        
//        //安全移除控制器的view;
//        
//        self.view = nil;
//        
//    }
}

-(void)onGoDownRefreshWeb:(void (^)())refreshDownCompleted{
    refreshDownCompleted();
    
    [self.baseWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.refrshUrl] ]];
}


#pragma mark- UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];

}



#pragma mark - LoginResultDelegate
-(void)showLoginResult:(BOOL)isSuccess withClickStr:(NSString *)clickStr{
    if (isSuccess) {
        //个人页成功后，由viewDidAppear做处理
    }else{
        //切换到首页
        [[HomTabBarController shareInstance] changeBarViewController:@"0"];
        
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self initLoginStatus];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end

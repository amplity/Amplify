//
//  BootWebViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/5/18.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BootWebViewController.h"
#import "AppDelegate.h"
#import "HomTabBarController.h"

@interface BootWebViewController ()

@end

@implementation BootWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.baseWebView.scrollView.bounces = NO;
    
    NSString *basePath = [[NSBundle mainBundle]bundlePath];
    NSString *helpHtmlPath = [basePath stringByAppendingPathComponent:@"index.html"];
    
    NSURL * url = [NSURL URLWithString:helpHtmlPath];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.baseWebView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIwebviewdeleg
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    
    
    BaseWebView * currentWebView = (BaseWebView*)webView;
    //滚动展示
    __weak typeof(self) weakSelf = self;
    
    
    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"appJump" withWebView:currentWebView withBlock:^(id jsToObject) {
        HomTabBarController * homTabBarController = [HomTabBarController shareInstance];
        [weakSelf presentViewController:homTabBarController animated:YES completion:nil];
    }];
    
    [UserManager saveFirstLaunch:YES];
}

@end

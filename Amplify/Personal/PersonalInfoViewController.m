//
//  PersonalInfoViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/5/16.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "PersonalUrlModel.h"
#import "DiscoverInfoViewController.h"
#import "LinkModel.h"

@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : HexRGB(0xffffff)}];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];

    PersonalUrlModel *personalUrlModel = (PersonalUrlModel *) self.inputViewData;
    NSString *comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:personalUrlModel.personalUrl withParameter:nil];
    [self.baseWebView baseLoadRequest:comUrl];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(execute:)
                                                 name:@"NOTIFICATION_RefreshPersonal_info"
                                               object:nil];
}

- (void)execute:(NSNotification *)notification {
    
    if ([notification.name isEqualToString:@"NOTIFICATION_RefreshPersonal_info"] ) {
        [self.baseWebView baseLoadRequest:self.refrshUrl];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.view.window == nil && [self isViewLoaded]) {
        //安全移除控制器的view;
        self.view = nil;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [super webViewDidFinishLoad:webView];
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
    //去支付,给后端传送是否安装了微信
    NSString *weixinStr = [[ThridPartManager manager] isWeixinInstall] ? @"1" : @"0";
    [[BaseWebManager shareWebManager] fixJavascriptDataByFun:[NSString stringWithFormat:@"getPayChangeType('%@')", weixinStr] withWebView:webView];
}

- (void)onGoDownRefreshWeb:(void (^)())refreshDownCompleted {
    refreshDownCompleted();
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end

//
//  WishNextViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/31.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "WishNextViewController.h"

@interface WishNextViewController ()

@end

@implementation WishNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:self.inputViewData withParameter:nil];
    if ([comUrl rangeOfString:@"rule"].length == 0) {
        self.navigationController.navigationBarHidden = YES;
    }
    [self.baseWebView baseLoadRequest:comUrl];
}

- (void)onGoDownRefreshWeb:(void (^)())refreshDownCompleted {
    refreshDownCompleted();
    [self.baseWebView baseLoadRequest:self.refrshUrl];
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
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end

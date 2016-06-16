//
// Created by kyros on 16/6/2.
// Copyright (c) 2016 hm. All rights reserved.
//

#import "SearchViewController.h"
#import "LinkModel.h"
#import "LinkManage.h"

@interface SearchViewController () {
    LinkModel *linkModel;
}
@end

@implementation SearchViewController
- (void)viewDidLoad {

    [super viewDidLoad];
    

    NSString *comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:self.inputViewData withParameter:nil];
    [self.baseWebView baseLoadRequest:comUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.view.window == nil && [self isViewLoaded]) {
        self.view = nil;
    }
}

- (void)onGoDownRefreshWeb:(void (^)())refreshDownCompleted {
    refreshDownCompleted();
    [self.baseWebView baseLoadRequest:self.refrshUrl];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [super webViewDidFinishLoad:webView];
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}
@end
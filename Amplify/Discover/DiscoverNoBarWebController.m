//
//  DiscoverNoBarWebController.m
//  Amplify
//
//  Created by ZhangJixu on 16/5/23.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "DiscoverNoBarWebController.h"
#import "LinkModel.h"

@interface DiscoverNoBarWebController (){
    LinkModel * linkModel;
}

@end

@implementation DiscoverNoBarWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.navigationController setHidesBarsOnSwipe:YES];
    
    linkModel = self.inputViewData;
    if (self.inputViewData) {
        self.navigationItem.title = linkModel.titleStr;
    }
    
    
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:linkModel.url withParameter:nil];
    
    [self.baseWebView baseLoadRequest:comUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)onGoDownRefreshWeb:(void (^)())refreshDownCompleted{
    refreshDownCompleted();
    [self.baseWebView baseLoadRequest:self.refrshUrl];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

@end

//
//  GoodListWebViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/18.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "GoodListWebViewController.h"
#import "BaseSearchViewController.h"
#import "LinkModel.h"
#import "LinkManage.h"

@interface GoodListWebViewController ()

@end

@implementation GoodListWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    NSString * urlStr = @"";
    if (self.inputViewData) {
        urlStr = self.inputViewData;
    }else{
        urlStr = @"";//填入
    }
    
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:urlStr withParameter:nil];
    [self.baseWebView baseLoadRequest:comUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if( self.view.window == nil && [self isViewLoaded]) {
        
        //安全移除控制器的view;
        
        self.view = nil;
        
    }
}


-(void)onGoDownRefreshWeb:(void (^)())refreshDownCompleted{
    [self.baseWebView baseLoadRequest:self.refrshUrl];
}

//搜索
-(void)goSearch:(id)sender{
//    BaseSearchViewController * baseSearchViewController = [[BaseSearchViewController alloc] init];
//    
//    [self.navigationController pushViewController:baseSearchViewController animated:YES];
    
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

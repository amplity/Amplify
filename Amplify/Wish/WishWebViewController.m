//
//  WishWebViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/22.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "WishWebViewController.h"
#import "BaseWebManager.h"
#import "WishInfoViewController.h"

@interface WishWebViewController ()

@end

@implementation WishWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:self.inputViewData withParameter:nil];
    
    [self.baseWebView baseLoadRequest:comUrl];
}

-(void)onGoDownRefreshWeb:(void (^)())refreshDownCompleted{
    refreshDownCompleted();
    
    [self.baseWebView baseLoadRequest:self.refrshUrl];
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

#pragma mark - UIwebviewdeleg
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
 
    
}


@end

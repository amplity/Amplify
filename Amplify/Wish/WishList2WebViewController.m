//
//  WishList2WebViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/27.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "WishList2WebViewController.h"
#import "WishInfoViewController.h"

@interface WishList2WebViewController ()

@end

@implementation WishList2WebViewController

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

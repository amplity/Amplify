//
//  HelpWebViewController.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/3.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "HelpWebViewController.h"
#import "HelpObject.h"

@interface HelpWebViewController ()

@end

@implementation HelpWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HelpObject * helpObject = (HelpObject*)self.inputViewData;
    
    self.title = helpObject.titileNameStr;
    
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:helpObject.httpUrl withParameter:nil];
    [self.baseWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:comUrl] ]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if( self.view.window == nil && [self isViewLoaded]) {
        
        //安全移除控制器的view;
        
        self.view = nil;
        
    }
}


-(void)onGoDownRefreshWeb:(void (^)())refreshDownCompleted{
    refreshDownCompleted();
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //每一次加载页面的时候都会触发
    NSString * url = request.URL.absoluteString;
    
    DLog(@"=================%@",url);
    
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
}


@end

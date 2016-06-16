//
//  DiscoverCategoryViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "DiscoverCategoryViewController.h"
#import "LinkModel.h"
#import "LinkManage.h"

@interface DiscoverCategoryViewController (){
    LinkModel * linkModel;
}

@end

@implementation DiscoverCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    linkModel = self.inputViewData;
    if (self.inputViewData) {
        self.navigationItem.title = linkModel.titleStr;
    }
    
    
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:linkModel.url withParameter:nil];
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
    refreshDownCompleted();
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:linkModel.url withParameter:nil];
    
    [self.baseWebView baseLoadRequest:comUrl];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    //js例子
    BaseWebView * currentWebView = (BaseWebView*)webView;
    currentWebView.loadSuccess = YES;
    
    
    
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
    
    
//    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    self.navigationItem.title = theTitle;
    
}

@end

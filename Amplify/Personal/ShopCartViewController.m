//
//  ShopCartViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/5/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "ShopCartViewController.h"
#import "BaseWebManager.h"
#import "SettlementViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>





@implementation ShopCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.navigationItem.title = @"化妆包";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HexRGB(0xffffff)}];
    
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
//    [self.baseWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.refrshUrl] ]];
    [self.baseWebView baseLoadRequest:self.refrshUrl];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];

    
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSString * comUrl;
    if (self.inputViewData) {
        comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:self.inputViewData withParameter:nil];
    }else{
        comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:@"/api/app/trolleyc/list" withParameter:[NSDictionary dictionaryWithObject:[UserManager token] forKey:@"token"]];
    }
    
    [self.baseWebView baseLoadRequest:comUrl];
}



@end

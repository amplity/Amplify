//
//  TestWebViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/22.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "TestWebViewController.h"
#import "BaseWebManager.h"

@interface TestWebViewController ()

@end

@implementation TestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    NSString *basePath = [[NSBundle mainBundle]bundlePath];
    NSString *helpHtmlPath = [basePath stringByAppendingPathComponent:@"amplifyTest.html"];
    
    NSURL * url = [NSURL URLWithString:helpHtmlPath];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.baseWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIwebviewdeleg
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString* givemetoken =  [NSString stringWithFormat:@"sendData('%@');",@"fffffffffff"];
//    [[BaseWebManager shareWebManager] fixJavascriptDataByFun:@"$obj.say()" withWebView:self.baseWebView];
    
    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"$obj.say" withWebView:self.baseWebView withBlock:^(id jsToObject) {
        DLog(@"$obj.say()");
    }];
}


@end

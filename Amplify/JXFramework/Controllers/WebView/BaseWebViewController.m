//
//  BaseWebViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseWebViewController.h"
#import "UserManager.h"

@interface BaseWebViewController (){
    //失败的webview和url
    NSMutableDictionary * faileWebViewDic;
}

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.baseWebView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    MJRefreshNormalHeader * refreshStateHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        DLog(@"下拉刷新成功！！！");
        [self onGoDownRefreshWeb:^{
            [self.baseWebView.scrollView.mj_header endRefreshing];
        }];
    }];
    refreshStateHeader.automaticallyChangeAlpha = YES;
    
    // 设置字体
    refreshStateHeader.stateLabel.font = [UIFont systemFontOfSize:13];
    refreshStateHeader.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:13];

//
//    // 设置颜色
//    refreshStateHeader.stateLabel.textColor = [UIColor blackColor];
//    refreshStateHeader.lastUpdatedTimeLabel.textColor = [UIColor blackColor];
    
    //隐藏时间
//    refreshStateHeader.lastUpdatedTimeLabel.hidden = YES;
    
    self.baseWebView.scrollView.mj_header = refreshStateHeader;
    
    faileWebViewDic = [[NSMutableDictionary alloc] initWithObjects:@[@"",@""] forKeys:@[@"currentWebView",@"failedUrl"]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onGoDownRefreshWeb:(void (^)())refreshDownCompleted{
    refreshDownCompleted();
    [self.baseWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.refrshUrl] ]];
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if (![request.URL.absoluteString hasSuffix:@"failed.html"]) {
         _refrshUrl = request.URL.absoluteString;
    }
    
    NSDictionary *dic = [request allHTTPHeaderFields];
    NSString* token = [dic objectForKey:@"token"];
    
    if(!token && ![request.URL.absoluteString hasSuffix:@"failed.html"]) {
        [self.baseWebView baseLoadRequest:request.URL.absoluteString];
        return FALSE;
    }
   
    
//    DLog(@"refrshUrl=%@",request.URL.absoluteString);
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
//    if ([self.baseWebView isLoading]) {
//        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
//    }else{
//        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    }
    
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
    
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none';"];
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    BaseWebView * currentWebView = (BaseWebView*)webView;
    
    
    NSString* givemetoken =  [NSString stringWithFormat:@"$m.app.call('%@','%@');",@"ios",[UserManager token]];
    [[BaseWebManager shareWebManager] fixJavascriptDataByFun:givemetoken withWebView:currentWebView];
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    //subClass
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    
    if ([[faileWebViewDic objectForKey:@"currentWebView"] isEqual:webView] && [[faileWebViewDic objectForKey:@"failedUrl"] isEqualToString:@"failed.html"]) {
        return;
    }
    
    [faileWebViewDic setValue:webView forKey:@"currentWebView"];
    [faileWebViewDic setValue:@"failed.html" forKey:@"failedUrl"];
    
    [self loadFailedWebHtml];
}

//加载失败页
-(void)loadFailedWebHtml{
    NSString *basePath = [[NSBundle mainBundle] bundlePath];
    NSString *helpHtmlPath = [basePath stringByAppendingPathComponent:@"failed.html"];
    
    NSURL * url = [NSURL URLWithString:helpHtmlPath];
    
    [self.baseWebView loadRequest:[NSURLRequest requestWithURL:url]];
}


-(void)goBlackView{
    //subclass
}

@end

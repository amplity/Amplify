//
//  ArticleCollectViewController2.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/28.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "ArticleCollectViewController2.h"
#import "BaseWebManager.h"
#import "UserManager.h"

@interface ArticleCollectViewController2 ()

@end

@implementation ArticleCollectViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:self.inputViewData withParameter:[NSDictionary dictionaryWithObject:[UserManager token] forKey:@"token"]];
    
    //?????????暂时写死，等登录逻辑完成后，去掉
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:self.inputViewData withParameter:[NSDictionary dictionaryWithObject:@"ODM0MzUwM2VNWHd4TkRReE5qSXdOelF4TVRVM05EVjhNVGcxTVRneE16UXlNalY4TVRRMU1qVTJORGM0TnpBd01BPT00ZmFkNTg5ODc4MjNhNTdmMDhiYmRkYjQ%3D" forKey:@"token"]];
    
    [self.baseWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:comUrl] ]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //返回
    BaseWebView * currentWebView = (BaseWebView*)webView;
    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"goback" withWebView:currentWebView withBlock:^(id jsToObject) {
        
        [self goBlackView];
        
        
    }];
}

-(void)goBlackView{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    
}

@end

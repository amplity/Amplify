//
//  ChangeCategoryViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "ChangeCategoryViewController.h"
#import "LinkModel.h"
#import "LinkManage.h"
#import "BaseSearchViewController.h"


@interface ChangeCategoryViewController ()

@end

@implementation ChangeCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:self.inputViewData withParameter:nil];
    
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
    
    [self.baseWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.refrshUrl]]];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
    
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
    
    
    BaseWebView * currentWebView = (BaseWebView*)webView;
    
    
//    __weak typeof(self) weakSelf = self;
//    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"visitUrl" withWebView:currentWebView withBlock:^(id jsToObject) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            LinkModel * linkModel = [[LinkModel alloc] init];
//            linkModel.url = [jsToObject objectAtIndex:0];
//            linkModel.type = [jsToObject objectAtIndex:1];
//            
//            [[LinkManage shareInstance] showWebViewByType:linkModel withOrigin:weakSelf];
//        });
//        
//    }];
//    
//    
//    //返回
//    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"goback" withWebView:currentWebView withBlock:^(id jsToObject) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf.navigationController popViewControllerAnimated:YES];
//        });
//        
//    }];
    
    
    //搜索
//    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"searchProduct" withWebView:currentWebView withBlock:^(id jsToObject) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            BaseSearchViewController * baseSearchViewController = [[BaseSearchViewController alloc] init];
//            [weakSelf.navigationController pushViewController:baseSearchViewController animated:YES];
//            
//        });
//        
//    }];
//    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}



@end

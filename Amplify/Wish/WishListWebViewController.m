//
//  WishListWebViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/27.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "WishListWebViewController.h"
#import "WishInfoViewController.h"

@interface WishListWebViewController ()

@end

@implementation WishListWebViewController

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
    
//    BaseWebView * currentWebView = (BaseWebView*)webView;
//    currentWebView.loadSuccess = YES;
//    
//    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"detail" withWebView:currentWebView withBlock:^(id jsToObject) {
//        
//        NSString * wishInfoUrl = [jsToObject objectAtIndex:0];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            WishInfoViewController * wishInfoViewController = [[WishInfoViewController alloc] init];
//            wishInfoViewController.inputViewData = wishInfoUrl;
//                        [self.navigationController pushViewController:wishInfoViewController animated:YES];
////            [self presentViewController:wishInfoViewController animated:YES completion:nil];
//        });
//        
//    }];
//    
////    NSString* givemetoken =  [NSString stringWithFormat:@"getToken('%@');",[UserManager token]];
////    [[BaseWebManager shareWebManager] fixJavascriptDataByFun:givemetoken withWebView:currentWebView];
    
}


@end

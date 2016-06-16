//
//  WishWeb2ViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/22.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "WishWeb2ViewController.h"
#import "BaseWebManager.h"
#import "WishInfoViewController.h"
#import "WishService.h"

@interface WishWeb2ViewController ()

@end

@implementation WishWeb2ViewController

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
//    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"$m_app_getUrl" withWebView:currentWebView withBlock:^(id jsToObject) {
//        
//        NSString * keyStr = [jsToObject objectAtIndex:0];
//        NSString * paramUrl = [jsToObject objectAtIndex:1];
//        NSString * paramStr = [jsToObject objectAtIndex:2];
//        
//        if([keyStr isEqualToString:@"remindMe"]){
//            [WishService remindme:paramStr withHandler:^(id responseObj) {
//                
//            } withHandler:^(NSError *error) {
//                
//            }];
//        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                WishInfoViewController * wishInfoViewController = [[WishInfoViewController alloc] init];
//                wishInfoViewController.inputViewData = paramUrl;
//                [self.navigationController pushViewController:wishInfoViewController animated:YES];
//                //            [self presentViewController:wishInfoViewController animated:YES completion:nil];
//            });
//        }
//        
//    }];
    
}



@end

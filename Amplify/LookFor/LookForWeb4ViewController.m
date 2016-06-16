//
//  LookForWeb4ViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/21.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "LookForWeb4ViewController.h"
#import "HomePageModel.h"
#import "AriticleInfoViewController.h"
#import "LookForShareFrameView.h"
#import "LoginViewController.h"
#import "MoviePlayerViewController.h"
#import "ShareModel.h"
#import "LookForService.h"

@interface LookForWeb4ViewController (){
    HomepageUrlData * homepageUrlData;
    ShareModel * shareModel;
}

@end

@implementation LookForWeb4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    homepageUrlData = self.inputViewData;
    
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:homepageUrlData.url withParameter:nil];
    [self.baseWebView baseLoadRequest:comUrl];
    
     shareModel = [[ShareModel alloc] init];
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

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
}


#pragma mark
-(void)showLoginResult:(BOOL)isSuccess withClickStr:(NSString *)clickStr{
    
    if (isSuccess) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            LookForShareFrameView * lookForShareFrameView = [LookForShareFrameView instancesViewWithBaseModel:shareModel];
            lookForShareFrameView.baseViewDelegate = self;
//            [self.view.window addSubview:lookForShareFrameView];
            
        });
    }
}



@end

//
//  LookForWebViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/21.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "LookForWebViewController.h"
#import "HomePageModel.h"
#import "AriticleInfoViewController.h"
#import "LookForShareFrameView.h"
#import "LoginViewController.h"
#import "MoviePlayerViewController.h"
#import "ShareModel.h"
#import "LookForService.h"
#import "AriticleInfoViewController.h"

@interface LookForWebViewController (){
    HomepageUrlData * homepageUrlData;
    
    ShareModel * shareModel;
}

@end

@implementation LookForWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImage *rightImage = [UIImage imageNamed:@"lookForStore"];
    rightImage =[rightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(likeStore:)];
    
    self.parentViewController.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
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


//收藏
-(void)likeStore:(id)sender{
    //收藏
     NSDictionary * storeDic = (NSDictionary*)[[BaseWebManager shareWebManager] fixJavascriptDataByFun:@"getArticleFav();" withWebView:self.baseWebView];
    
    NSString * storeUrl = [storeDic objectForKey:@"url"];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        AriticleInfoViewController * ariticleInfoViewController = [[AriticleInfoViewController alloc] init];
        ariticleInfoViewController.inputViewData = storeUrl;
        [weakSelf.navigationController pushViewController:ariticleInfoViewController animated:YES];
    });
    
    
    
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
//    BaseWebView * currentWebView = (BaseWebView*)webView;
//    currentWebView.loadSuccess = YES;
//    
//    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
//    
//    __weak typeof(self)weakSelf = self;
//    
//    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"getArticleMsg" withWebView:currentWebView withBlock:^(id jsToObject) {
//        //切换到新webviewController
//        NSArray *  valueDatas = jsToObject;
//        
//        NSString * type = [valueDatas objectAtIndex:1];
//        if (type.integerValue==LookForArticleInside) {
//            AriticleInfoViewController * ariticleInfoViewController = [[AriticleInfoViewController alloc] init];
//            ariticleInfoViewController.inputViewData = [valueDatas objectAtIndex:0];
//            
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.navigationController pushViewController:ariticleInfoViewController animated:YES];
//            });
//            
//        }else{
//            AriticleInfoViewController * ariticleInfoViewController = [[AriticleInfoViewController alloc] init];
//            ariticleInfoViewController.inputViewData = [valueDatas objectAtIndex:0];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.navigationController pushViewController:ariticleInfoViewController animated:YES];
//            });
//        }
//    }];
//    
//    //分享
//    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"shareArticle" withWebView:currentWebView withBlock:^(id jsToObject) {
//        
//        shareModel.businessId = [jsToObject objectAtIndex:0];
//        
//        
//        
//        if ([UserManager isLogin]) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                LookForShareFrameView * lookForShareFrameView = [LookForShareFrameView instancesViewWithBaseModel:shareModel];
//                lookForShareFrameView.baseViewDelegate = self;
//                [self.view.window addSubview:lookForShareFrameView];
//                
//            });
//        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                LoginViewController * loginViewController = [LoginViewController alloc];
//                loginViewController.loginRestltDelegate = self;
//                [self.navigationController pushViewController:loginViewController animated:YES];
//            });
//            
//        }
//        
//    }];
//    
//    //视频
//    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"playVideo" withWebView:currentWebView withBlock:^(id jsToObject) {
//        
//        NSString * titleStr = [jsToObject objectAtIndex:1];//标题
//        NSString * movieUrl = [jsToObject objectAtIndex:0];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            MoviePlayerViewController * movie = [[MoviePlayerViewController alloc] init];
//            __weak typeof(movie) weakMovie = movie;
//            __weak typeof(self) weakSelf = self;
//            
//            
//            NSString * urlName = movieUrl;
//            urlName = [urlName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            weakMovie.url = urlName;
//            weakMovie.danmaku = @"";
//            weakMovie.titleStr = titleStr;
//            if (weakSelf.presentedViewController == nil) {
//                
//                [weakSelf presentViewController:movie animated:NO completion:nil];
//            }
//            
//        });
//        
//    }];
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

//
//  BaseWebViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseWebView.h"
#import "BaseWebManager.h"
#import "MBProgressHUD.h"
#import "BaseWebControllerManager.h"

@interface BaseWebViewController : BaseViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet BaseWebView *baseWebView;

@property (weak,nonatomic) MBProgressHUD *hud;

@property (nonatomic, strong) NSString *refrshUrl;

//下拉刷新
-(void)onGoDownRefreshWeb:(void(^)())refreshDownCompleted;


-(void)goBlackView;

@end

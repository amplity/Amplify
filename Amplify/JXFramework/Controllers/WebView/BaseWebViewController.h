//
//  BaseWebViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseWebView.h"

@interface BaseWebViewController : BaseViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet BaseWebView *baseWebView;

@end

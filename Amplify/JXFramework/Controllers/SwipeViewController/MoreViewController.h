//
//  MoreViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"

@interface MoreViewController : BaseViewController<UIWebViewDelegate>


@property (nonatomic, retain) UIWebView *myWebView;
@property (nonatomic, retain) id dataObject;

@end

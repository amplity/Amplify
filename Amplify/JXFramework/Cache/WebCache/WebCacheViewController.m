//
//  WebCacheViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "WebCacheViewController.h"
#import "CustomURLCache.h"

@interface WebCacheViewController ()

@end

@implementation WebCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                     diskCapacity:200 * 1024 * 1024
                                                                         diskPath:nil
                                                                        cacheTime:0];
    [CustomURLCache setSharedURLCache:urlCache];
    

//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSString *basePath = [[NSBundle mainBundle]bundlePath];
    NSString *helpHtmlPath = [basePath stringByAppendingPathComponent:@"amplifyTest.html"];
    
    NSURL * url = [NSURL URLWithString:helpHtmlPath];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url];
    
    [self.baseWebView loadRequest:urlRequest];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    CustomURLCache * urlCache = (CustomURLCache*)[NSURLCache sharedURLCache];
    [urlCache removeAllCachedResponses];
}

@end

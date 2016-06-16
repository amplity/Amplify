//
//  BaseWebView.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseWebView.h"

@implementation BaseWebView


-(void)baseLoadRequest:(NSString*)url{
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.0];
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    NSString* tonken = [UserManager token];
    [mutableRequest addValue:tonken forHTTPHeaderField:@"token"];
    
    [self loadRequest:mutableRequest];
    
}


@end

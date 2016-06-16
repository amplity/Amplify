//
//  BaseWebView.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <UIKit/UIKit.h>//

//static const NSString * WebLoadUrl = @"http://192.168.30.234";
static const NSString * WebLoadUrl = @"http://www.harmay.com";
//static NSString * const WebLoadUrl = @"http://test1.harmay.com";
//static const NSString * WebLoadUrl = @"http://192.168.30.2";

@interface BaseWebView : UIWebView

@property (nonatomic) BOOL loadSuccess;


/**
 *  web加载，内部添加了头部,封装了request
 *
 *  @param url
 */
-(void)baseLoadRequest:(NSString*)url;

@end

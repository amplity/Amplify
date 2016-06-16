//
//  BaseWebControllerManager.h
//  Amplify
//
//  Created by ZhangJixu on 16/5/20.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "BaseWebView.h"

@interface BaseWebControllerManager : NSObject


+(instancetype)shareWebManager;


/**
 *  js 调用原生 (共有方法，负责页面的切换)
 *
 *  @param jsMethod           js方法
 *  @param baseViewController js加载的页面
 *  @param baseWebView        js加载页面的baseWebView
 */
-(void)pushControllerForJsObject:(BaseViewController*)baseViewController withBaseWebView:(UIWebView*)baseWebView;

@end

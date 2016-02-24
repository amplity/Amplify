//
//  BaseWebManager.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/22.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseWebView.h"

typedef void(^webViewJsToOC)(id jsToObject);
@interface BaseWebManager : NSObject


+(instancetype)shareWebManager;

/**
 *  调用js方法，返回数据
 *
 *  @param funName js 方法名称
 *  @param webView 当前的webview
 *
 *  @return js 返回数据
 */
-(NSDictionary*)fixJavascriptDataByFun:(NSString *)funName withWebView:(UIWebView*)webView;

/**
 *  js传值给oc
 *
 *  @param funNameStr js方法名
 *  @param webView    当前显示的webview
 *  @param block      回调bolock
 */
-(void)sendJsDataForObjcet:(NSString*)funNameStr withWebView:(BaseWebView*)webView withBlock:(webViewJsToOC)block;


/**
 *  oc传值给js
 *
 *  @param funName    js方法名
 *  @param parameters js参数
 *  @param webView    当前webView
 *
 *  @return js返回值
 */
-(NSDictionary*)fixJavascriptDataByFunWithParameter:(NSString *)funName withParameter:(NSArray*)parameters withWebView:(UIWebView*)webView;
    
@end

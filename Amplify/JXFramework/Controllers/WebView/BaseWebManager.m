//
//  BaseWebManager.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/22.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseWebManager.h"
#import <JavaScriptCore/JavaScriptCore.h>


@implementation BaseWebManager


+(instancetype)shareWebManager{
    static BaseWebManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BaseWebManager alloc] init];
    });
    
    return instance;
}

-(NSDictionary*)fixJavascriptDataByFun:(NSString *)funName withWebView:(UIWebView*)webView{
    //可以传值给js
//    NSString* givemetoken =  [NSString stringWithFormat:@"givetoken('%@');",[[UserInfoManager sharedManager] getAppToken]];
    
    NSDictionary * dic = [[NSDictionary alloc] init];
    
    if([funName isEqualToString:@""]|| !funName){
        return dic;
    }else{
        //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
        JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        
        JSValue * jsValue =[context evaluateScript:funName];////准备执行的js代码,通过oc方法调用js的alert
        
        
        dic = [jsValue toDictionary];
        
        
        //    NSString * ffff = [self.baseWebView stringByEvaluatingJavaScriptFromString:@"postStr();"];
        //    DLog(@"=================%@",ffff);
    }
    
    return dic;
    
}

-(NSDictionary*)fixJavascriptDataByFunWithParameter:(NSString *)funName withParameter:(NSArray*)parameters withWebView:(UIWebView*)webView{
    NSDictionary * dic = [[NSDictionary alloc] init];
    
    if([funName isEqualToString:@""]|| !funName){
        return dic;
    }else{
        //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
        JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        
        
        JSValue * jsValue =context[funName];//js方法，只有方法名。eg：context[@“sendData”]
        
        JSValue *newJsva = [jsValue callWithArguments:parameters];
        
        dic = [newJsva toDictionary];
        
    }
    
    return dic;

}


//js传参给oc
-(void)sendJsDataForObjcet:(NSString*)funNameStr withWebView:(BaseWebView*)webView withBlock:(webViewJsToOC)block{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    
        context[funNameStr] = ^() {
            NSArray *args = [JSContext currentArguments];
            
            NSMutableArray * jsArray = [NSMutableArray array];
            for (JSValue *jsVal in args) {
                [jsArray addObject:[jsVal toString]];
            }
            
            block(jsArray);
        };
    
}
@end

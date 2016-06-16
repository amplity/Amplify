//
//  ScrollTabData.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/13.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseData.h"
#import "BaseWebView.h"

@interface ScrollTabData : BaseData

//标题
@property (nonatomic, strong) NSString *title;

//BaseWebView
@property (nonatomic, strong) BaseWebView *baseWebView;

@end

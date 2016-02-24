//
//  UtilsManager.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/19.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilsManager : NSObject

+(instancetype)shareInstance;

- (UIViewController *)getCurrentVC;

//获取当前屏幕中present出来的viewcontroller
- (UIViewController *)getPresentedViewController;

@end

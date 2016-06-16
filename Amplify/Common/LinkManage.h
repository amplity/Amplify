//
//  LinkManage.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkModel.h"
#import "BaseViewController.h"

@interface LinkManage : NSObject

+(instancetype)shareInstance;

-(void)showWebViewByType:(LinkModel*)linkModel withOrigin:(BaseViewController*)originViewController;

@end

//
//  ShareManage.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/28.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@interface ShareManage : NSObject

+(instancetype)shareInstance;

-(void)shareViewController:(BaseViewController*)viewController withParagmer:(id)paragmer;
@end

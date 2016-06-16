//
//  TipManager.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/4.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "TipManager.h"

@implementation TipManager


+(void)showTipsWithInforStr:(NSString*)infoStr withAfter:(NSTimeInterval)afterTime{
    [JDStatusBarNotification showWithStatus:infoStr dismissAfter:afterTime];
}
@end

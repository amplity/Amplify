//
//  TipManager.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/4.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <JDStatusBarNotification/JDStatusBarNotification.h>

@interface TipManager : JDStatusBarNotification


/**
 *  显示消息
 *
 *  @param infoStr 消息文本 afterTimer显示时间
 */
+(void)showTipsWithInforStr:(NSString*)infoSt withAfter:(NSTimeInterval)afterTimer;
@end

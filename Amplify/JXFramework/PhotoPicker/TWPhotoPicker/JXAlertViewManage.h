//
//  JXAlertViewManage.h
//  Amplify
//
//  Created by ZhangJixu on 16/5/26.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXAlertViewManage : NSObject


/**
 *  提示框
 *
 *  @param title  标题
 *  @param info   信息
 *  @param status 提示状态（成功，失败，警告，等等）
 */
+(void)showViewWithAlert:(NSString*)title withInfo:(NSString*)info withStatus:(NSString*)status;




//无标题
+(void)showMessageWithAlert:(NSString*)info;
@end

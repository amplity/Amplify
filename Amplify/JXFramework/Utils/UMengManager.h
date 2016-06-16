//
//  UMengManager.h
//  Amplify
//
//  Created by ZhangJixu on 16/6/14.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMengManager : NSObject

+(instancetype)uMengInstance;

/**
 *  友盟启动
 */
-(void)setStart;

/** 自动页面时长统计, 开始记录某个页面展示时长.
 使用方法：必须配对调用beginLogPageView:和endLogPageView:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。
 在该页面展示时调用beginLogPageView:，当退出该页面时调用endLogPageView:
 @param pageName 统计的页面名称.
 @return void.
 */
-(void)beginLogPageView:(NSString *)pageName;


/** 自动页面时长统计, 结束记录某个页面展示时长.
 使用方法：必须配对调用beginLogPageView:和endLogPageView:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。
 在该页面展示时调用beginLogPageView:，当退出该页面时调用endLogPageView:
 @param pageName 统计的页面名称.
 @return void.
 */
-(void)endLogPageView:(NSString *)pageName;

/**
 * @param  eventId 网站上注册的事件Id.
 @param  label 分类标签。不同的标签会分别进行统计，方便同一事件的不同标签的对比,为nil或空字符串时后台会生成和eventId同名的标签.
 @param  accumulation 累加值。为减少网络交互，可以自行对某一事件ID的某一分类标签进行累加，再传入次数作为参数。
 */

-(void)event:(NSString *)eventId; //等同于 event:eventId label:eventId;
/** 自定义事件,数量统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID
 */
-(void)event:(NSString *)eventId label:(NSString *)label; // label为nil或@""时，等同于 event:eventId label:eventId;
@end

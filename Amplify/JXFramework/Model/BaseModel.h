//
//  BaseModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/4.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface BaseModel : NSObject

//公用数据

/**
 *  消息提示
 */
@property (nonatomic) NSString * msgStr;



//mj_objectWithKeyValues 公用的方法，转化为json

@end

@interface ResponseBody : NSObject

@end

@interface ResponseHead : NSObject

@end

//
//  BaseModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/4.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@class ResponseHead;
@interface BaseModel : NSObject

//mj_objectWithKeyValues 公用的方法，转化为json

@property (nonatomic, strong) ResponseHead *responseHead;


@end

@interface ResponseBody : NSObject

@end

@interface ResponseHead : NSObject

/**
 *  消息提示
 */
@property (nonatomic) NSString * msg;

@property (nonatomic, strong) NSString *code;


@property (nonatomic, strong) NSString *token;


@property (nonatomic, strong) NSString *error;

@property (nonatomic, strong) NSString *expire;
@end

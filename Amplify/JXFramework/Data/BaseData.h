//
//  BaseData.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/4.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseData : NSObject

//以下为例子
@property (nonatomic) NSString * name;

@property (nonatomic) NSString * num;

//end

+(instancetype)initDataForProperty:(NSArray*)propertys;
@end

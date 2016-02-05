//
//  BaseData.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/4.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseData.h"

@implementation BaseData


+(instancetype)initDataForProperty:(NSArray*)propertys{
    BaseData * baseData = [[BaseData alloc] init];
    
    
    for (id obj in propertys) {
        baseData.name = obj;
        baseData.num = obj;
    }
    
    return baseData;
    
    
    //subClass;
}
@end

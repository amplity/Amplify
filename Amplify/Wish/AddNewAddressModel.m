//
//  AddNewAddressModel.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "AddNewAddressModel.h"

@implementation AddNewAddressModel
-(NSMutableArray *)provincess{
    if (!_provincess) {
        _provincess = [NSMutableArray array];
    }
    
    return _provincess;
}

@end


@implementation City

//+(NSDictionary*)mj_objectClassInArray{
//    return @{
//             @"children" : @"Area",
//             };
//}

-(NSMutableArray*)children{
    if (!_children) {
        _children = [NSMutableArray array];
    }
    
    return _children;
}

@end
@implementation Province

//+(NSDictionary*)mj_objectClassInArray{
//    return @{
//             @"children" : @"City",
//             };
//}

-(NSMutableArray*)children{
    if (!_children) {
        _children = [NSMutableArray array];
    }
    return _children;
}

@end

@implementation Area

@end

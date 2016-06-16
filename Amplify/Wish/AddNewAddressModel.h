//
//  AddNewAddressModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

@interface AddNewAddressModel : BaseModel


//省组
@property (nonatomic) NSMutableArray* provincess;

@end


@interface Province : NSObject
@property (nonatomic) NSString * name;
@property (nonatomic, weak) NSString *regionId;
@property (nonatomic, weak) NSString *regionCode;
//市组
@property (nonatomic) NSMutableArray * children;

@end


@interface City : NSObject
@property (nonatomic) NSString * name;
@property (nonatomic) NSString * regionCode;
@property (nonatomic, weak) NSString *regionId;
@property (nonatomic) NSMutableArray * children;

@end

@interface Area : NSObject
@property (nonatomic) NSString * name;
@property (nonatomic) NSString * regionCode;
@property (nonatomic, weak) NSString *regionId;


@end

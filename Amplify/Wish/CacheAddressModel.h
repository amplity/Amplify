//
//  CacheAddressModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/1.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

@interface CacheAddressModel : BaseModel

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *addressInfo;

@property (nonatomic, strong) NSString *addressNum;//邮编

@property (nonatomic, strong) NSString *regionCode;


@property (nonatomic, strong) NSString *provincesStr;//省、市、区 合一

@property (nonatomic, strong) NSString *wishId;


@property (nonatomic, strong) NSString *comId;

@property (nonatomic, strong) NSString *address;


//来源于新添加地址
@property (nonatomic,strong) NSString *addressId;

@end

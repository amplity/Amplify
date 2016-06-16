//
//  AddressListModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/6/1.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

@class AddressListBody;
@interface AddressListModel : BaseModel

@property (nonatomic) AddressListBody *responseBody;

@end

@interface AddressListBody : ResponseBody

@property (nonatomic) NSMutableArray *addrList;


@property (nonatomic,assign) NSInteger selectIndex;

@end



@interface AddressListData : NSObject

@property (nonatomic) NSString *countyName;

@property (nonatomic) NSString *phone;

@property (nonatomic) NSString *cityName;

@property (nonatomic) NSString *email;//邮编

@property (nonatomic) NSString *provinceName;


@property (nonatomic) NSString *name;//名字

@property (nonatomic) NSString *county;//县id

@property (nonatomic) NSString *addressId;

@property (nonatomic) NSString *address;


@end




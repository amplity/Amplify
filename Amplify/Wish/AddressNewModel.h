//
//  AddressNewModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"


@class AddressNewBody;
@interface AddressNewModel : BaseModel

@property (nonatomic) AddressNewBody *responseBody;

@end


@interface AddressNewBody : ResponseBody


@property (nonatomic, copy) NSString *orderId;

@end
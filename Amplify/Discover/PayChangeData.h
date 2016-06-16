//
//  PayChangeData.h
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/15.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "BaseModel.h"

@class PayChangeBody;
@interface PayChangeData : BaseModel

@property (nonatomic, copy) PayChangeBody *responseBody;

@end


@class PayOrderInfo;
@class Charge;
@interface PayChangeBody :ResponseBody

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *cashChannel;

@property (nonatomic,copy) NSString * realAmount;

@property (nonatomic, copy) NSString *jfAmount;

@property (nonatomic, copy) Charge* charge;

//@property (nonatomic, copy) PayOrderInfo *payParams;

@end

@interface PayOrderInfo : NSObject

@end

@interface Charge : NSObject

@property (nonatomic, copy) NSString *body;
@end



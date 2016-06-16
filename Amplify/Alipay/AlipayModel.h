//
//  AlipayModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/12.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

@interface AlipayModel : BaseModel


//暂时
@property (nonatomic) CGFloat total_fee;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;

//回调url
@property (nonatomic, copy) NSString *notify_url;


@property (nonatomic, copy) NSString *currency;


@end

//
//  SettlementModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/5/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

@class SettlementBody;
@interface SettlementModel : BaseModel


@property (nonatomic,strong) SettlementBody *responseBody;
@end

@interface SettlementBody : ResponseBody

@property (nonatomic, weak) NSString *url;

@end

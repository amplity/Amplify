//
//  ShareModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

@interface ShareModel : BaseModel


@property (nonatomic, copy) NSString *businessId;


@property (nonatomic, copy) NSString *wishId;

@property (nonatomic, copy) NSString *type;


@property (nonatomic)  BOOL isEndShare;

@end

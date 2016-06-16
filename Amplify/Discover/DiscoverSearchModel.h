//
//  DiscoverSearchModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

@class DiscoverSearchBody;
@interface DiscoverSearchModel : BaseModel


@property (nonatomic, strong) DiscoverSearchBody *responseBody;
@end



@interface DiscoverSearchBody : NSObject


@property (nonatomic, strong) NSArray *hotWords;

@property (nonatomic, strong) NSArray *history;


@end

//
//  LookForShareModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

@class LookForShareBody;
@interface LookForShareModel : BaseModel
@property (nonatomic) LookForShareBody *responseBody;

@end

@interface LookForShareBody : ResponseBody

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *imageUrl;

@end
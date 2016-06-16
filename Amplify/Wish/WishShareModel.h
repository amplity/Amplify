//
//  WishShareModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/27.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

@class WishShareBody;
@interface WishShareModel : BaseModel


@property (nonatomic) WishShareBody *responseBody;

@end

@interface WishShareBody : ResponseBody


@property (nonatomic, copy) NSString *title;


@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *imgurl;


@property (nonatomic, copy) NSString *shareurl;
@end

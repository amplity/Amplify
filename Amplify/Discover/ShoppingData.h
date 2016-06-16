//
//  ShoppingData.h
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/4.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "BaseModel.h"


@class ShopingBody;
@interface ShoppingData : BaseModel





@property (nonatomic) ShopingBody *responseBody;


//@property (nonatomic, copy) NSString *state;
//
//@property (nonatomic, assign) NSInteger num;

@end

@interface ShopingBody : ResponseBody

@property (nonatomic,copy) NSString* url;

@property (nonatomic, copy) NSString *totalNum;

@end

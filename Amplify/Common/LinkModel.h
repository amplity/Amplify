//
//  LinkModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"


typedef enum{
    //1.分类 2.品牌 3.商品详情 4.物色 5.心愿 6.活动  7.商品列表  15.其他
    LinkCategory = 1,
    LinkBrand = 2,
    LinkGood = 3,
    LinkLookFor = 4,
    LinkWish = 5,
    LinkActive = 6,
    LinkGoodList = 7,
    LinkOther = 15
}DiscoveryUrlType;
@interface LinkModel : BaseModel

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *url;

@property (nonatomic, copy) NSString *titleStr;

@end

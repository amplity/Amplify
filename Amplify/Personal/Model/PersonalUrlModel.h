//
//  PersonalUrlModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/5/16.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

typedef enum{
    //type:1.订单 2.退款售后 3.积分 4.个人信息 5.地址管理 6.服务反馈 7.收藏 8.账号绑定
    PersonalUrlType = 1,
    PersonalUrlSelled = 2,
    PersonalUrlJiFen = 3,
    PersonalUrlMeInfo = 4,
    PersonalUrlAddress = 5,
    PersonalUrlServices = 6,
    PersonalUrlStore = 7,
    PersonalUrlBind = 8

}PersonalUrlModelType;

@interface PersonalUrlModel : BaseModel

@property (nonatomic, copy) NSString *personalUrl;

@property (nonatomic, weak) NSString *type;

@end

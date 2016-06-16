//
//  WishInfoModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/30.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

typedef enum{
    WishInfoJoin = 0,
    WishInfNotCome =10,
    WishInfoCome = 11,
    WishInfoUnSuccess = 20,
    WishInfoSuccess = 21,
    WishInfoSuccessDotSend = 22
    
}WishInfoStatus;

typedef enum{
    WishUploadHasIcon = 1,
    WishDotUploadHasIcon =2,
    WishUploadDotIcon = 3,
    WishDotUploadDotIcon = 4
    
}WishInfoFlag;

@class WishInfoBody;
@interface WishInfoModel : BaseModel

@property (nonatomic) WishInfoBody *responseBody;

//来源，是否为上传照片
@property(nonatomic) BOOL isFormPhoto;

@end


@class WishingUser;
@interface WishInfoBody : ResponseBody

//1有图可上传 2有图不可上传 3无图可上传 4无图不可上传
@property (nonatomic, assign) NSInteger flag;


@property (nonatomic, copy) NSString *desc;


@property (nonatomic, copy) NSString *wishId;

@property (nonatomic, copy) NSString *imgurl;

//0：参与；10：未入围，11：已入围，20：未达成，21：已达成 ,22:已达成未公布
@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *resttime;

@property (nonatomic, copy) NSString *joinNum;

@property (nonatomic, copy) NSString *passjf;

@property (nonatomic, copy) NSString *uploadjf;

//0 没有地址需要用户填写  1有地址了,有订单
@property (nonatomic,copy) NSString * address;

@property (nonatomic, copy) NSString *comId;




@end


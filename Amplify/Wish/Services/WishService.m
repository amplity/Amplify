//
//  WishService.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/22.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "WishService.h"

@implementation WishService

//图片上传

+(void)UploadImageForWish:(UIImage*)image witWishId:(NSString*)wishId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@?token=%@&wishId=%@",@"/app/wish/uploadpic",[UserManager token],wishId];
    [BaseService upLoadForImageRequest:urlStr withImage:image withSuccess:handler withFail:failHandler];
    
}


+(void)getListwish:(NSInteger)status withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    [BaseService getDataWithUrl:@"app/wish/listwish" withParameters:@{@"status":[NSString stringWithFormat:@"%ld",(long)status]} withSuccess:handler withFail:failHandler];
}


+(void)upinfo:(NSString*)wishId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandle{
    
    [BaseService postDataWithUrl:@"rest/upinfo" withParameters:@{@"wishId":wishId} withSuccess:handler withFail:failHandle];
}


+(void)addNewAddressForWish:(NSString*)name withPhone:(NSString*)phone withAddress:(NSString*)address withRegioncode:(NSString*)regioncode withWishId:(NSString*)wishId withComId:(NSString*)comId withAddressId:(NSString*)addressId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    
    [BaseService postDataWithUrl:@"rest/newaddress" withParameters:@{@"name":name,@"phone":phone,@"address":address,@"county":regioncode,@"wishId":wishId,@"comId":comId,@"addressId":addressId} withSuccess:handler withFail:failHandler];
}


+(void)wishShare:(NSString*)wishId withType:(NSString*)type withChannel:(NSString*)channel withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    
    
    NSString * token = [UserManager token];
    [BaseService postDataWithUrl:@"rest/app/wish/sharewishurl" withParameters:@{@"wishId":wishId,@"type":type,@"channel":channel} withSuccess:handler withFail:failHandler];
}


+(void)remindme:(NSString*)wishId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    [BaseService postDataWithUrl:@"rest/remindme" withParameters:@{@"remindMe":@{@"wishId":wishId,@"id":@"",@"memberId":@""}} withSuccess:handler withFail:failHandler];
}

+(void)getAddressList:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    [BaseService postDataWithUrl:@"rest/getAddressList" withParameters:@{} withSuccess:handler withFail:failHandler];
}

@end


//
//  LoginService.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/11/30.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "LoginService.h"

@implementation LoginService


+(void)getAccountInfo:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"rest/?method=getAccountInfo" withParameters:@{} withSuccess:handler withFail:failRequestBlock];
}

+(void)wxOauth:(NSString *)url withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
//    [[LoginService sharedService] getPlain:url withHandler:handler];
    
    [BaseService getDataWithUrl:url withParameters:@{} withSuccess:handler withFail:failRequestBlock];
}

+(void)wxInfor:(NSString *)url withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
//    [[LoginService sharedService] getPlain:url withHandler:handler];
    [BaseService getDataWithUrl:url withParameters:@{} withSuccess:handler withFail:failRequestBlock];
}

+(void)wxBindLogin:(NSString*)encryptUID withThirdPlatform:(NSString*)thirdPlatform withuid:(NSString*)uid withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"thirdPlatformBinding" withParameters:@{@"encryptUID":encryptUID,@"thirdPlatform":thirdPlatform,@"id":uid} withSuccess:handler withFail:failRequestBlock];
}


+(void)weiboInfor:(NSString *)url withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
//    [[LoginService sharedService] getPlain:url withHandler:handler];
    [BaseService getDataWithUrl:url withParameters:@{} withSuccess:handler withFail:failRequestBlock];
}


+(void)weiboAndWeiXiLogin:(NSString*)uid withProfileUrl:(NSString*)profileUrl withGender:(NSString*)gender withDisplayName:(NSString*)displayName withThirdPlatform:(NSString*)thirdPlatform withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"thirdPartLogin" withParameters:@{@"displayName":displayName,@"thirdPlatform":thirdPlatform,@"gender":gender,@"profileUrl":profileUrl,@"id":uid} withSuccess:handler withFail:failRequestBlock];
}


+(void)isWeiboAndWeiXiBind:(NSString*)type withUnionId:(NSString*)unionId withOpenId:(NSString*)openId wihNickName:(NSString*)nickName withProfileUrl:(NSString*)profileUrl withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"rest/returnunion" withParameters:@{@"type":type,@"unionId":unionId,@"openId":openId} withSuccess:handler withFail:failRequestBlock];
}

+(void)weiboAndWeiXiBindForAccount:(NSString *)uid withProfileUrl:(NSString *)profileUrl withGender:(NSString *)gender withUnionId:(NSString*)unionId withMsCode:(NSString*)msCode withPhone:(NSString*)phone withDisplayName:(NSString *)displayName withThirdPlatform:(NSString *)thirdPlatform withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    NSDictionary * memberDic = @{@"phone":phone,@"code":msCode};
    NSDictionary * bindRecordDic = @{@"bindAccount":uid,@"bindPlateform":thirdPlatform,@"unionId":unionId,@"mpOpenId":uid,@"nickName":displayName,@"profileUrl":profileUrl};
    
    [BaseService postDataWithUrl:@"rest/completeinfonew" withParameters:@{@"member":memberDic,@"bindRecord":bindRecordDic} withSuccess:handler withFail:failRequestBlock];
}

+(void)weiboAndWeixiBind:(NSString *)uid withPhone:(NSString*)phone withPassword:(NSString *)password withGender:(NSString *)gender withThirdPlatform:(NSString *)thirdPlatform withUnionId:(NSString*)unionId withDisplayName:(NSString *)displayName withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    NSDictionary * memberDic = @{@"phone":phone,@"password":password};
    NSDictionary * bindRecordDic = @{@"bindAccount":uid,@"bindPlateform":thirdPlatform,@"unionId":unionId,@"nickName":displayName};
    
    [BaseService postDataWithUrl:@"rest/completeinfoold" withParameters:@{@"member":memberDic,@"bindRecord":bindRecordDic} withSuccess:handler withFail:failRequestBlock];
}

+(void)weiboBindLogin:(NSString *)encryptUID withThirdPlatform:(NSString *)thirdPlatform withuid:(NSString *)uid withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"thirdPartLogin" withParameters:@{@"encryptUID":encryptUID,@"thirdPlatform":thirdPlatform} withSuccess:handler withFail:failRequestBlock];
}




+(void)authentication:(NSString *)phoneNum withPassword:(NSString *)password withSmsCode:(NSString*)smsCode withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"rest/?method=authentication" withParameters:@{@"phoneNum":phoneNum,@"password":password,@"smsCode":smsCode} withSuccess:handler withFail:failRequestBlock];
}

+(void)sendSMSCode:(NSString *)phoneNum withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"rest/?method=sendSMSCode" withParameters:@{@"phoneNum":phoneNum} withSuccess:handler withFail:failRequestBlock];
}

+(void)submitCheckCode:(NSString*)phoneNum withSmsCode:(NSString*)smsCode withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"rest/checkCodeForCreateAccount" withParameters:@{@"phoneNum":phoneNum,@"smsCode":smsCode} withSuccess:handler withFail:failRequestBlock];
}

+(void)sendSMSCodeForResetPwd:(NSString*)phoneNum withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"rest/?method=sendSMSCodeForResetPwd" withParameters:@{@"phoneNum":phoneNum} withSuccess:handler withFail:failRequestBlock];
}

+(void)checkSmsCode:(NSString *)phoneNum withSmsCode:(NSString *)smsCode withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"rest/?method=checkSmsCode" withParameters:@{@"phoneNum":phoneNum,@"smsCode":smsCode} withSuccess:handler withFail:failRequestBlock];
}

+(void)resetPassword:(NSString*)phoneNum withPassword:(NSString*)password withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"rest/?method=resetPassword" withParameters:@{@"phoneNum":phoneNum,@"password":password} withSuccess:handler withFail:failRequestBlock];
}

+(void)regiserResetPassword:(NSString*)phoneNum withPassword:(NSString*)password withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"rest/setPwdForCreateAccount" withParameters:@{@"phoneNum":phoneNum,@"password":password} withSuccess:handler withFail:failRequestBlock];
}

//刷新token
+(void)refreshToken:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"getoken" withParameters:@{} withSuccess:handler withFail:failRequestBlock];
}

+(void)getServiceTime:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    
    [BaseService postDataWithUrl:@"systime" withParameters:@{} withSuccess:handler withFail:failRequestBlock];
}


+(void)jPushRegistrationId:(NSString*)registrationId withdeviceId:(NSString*)deviceId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler{
    [BaseService postDataWithUrl:@"rest/registrationid" withParameters:@{@"registrationId":registrationId,@"deviceId":deviceId} withSuccess:handler withFail:failHandler];
}


//个人中心绑定
+(void)personalWxAndWbBind:(NSString *)displayName withUnionId:(NSString*)unionId withOpenId:(NSString*)openId withThirdPlatform:(NSString*)thirdPlatform withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock{
    [BaseService postDataWithUrl:@"rest/bindingThirdPlatform" withParameters:@{@"displayName":displayName,@"unionId":unionId,@"openId":openId,@"thirdPlatform":thirdPlatform} withSuccess:handler withFail:failRequestBlock];
}
@end

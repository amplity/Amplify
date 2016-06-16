//
//  LoginService.h
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/11/30.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "BaseService.h"

@interface LoginService : BaseService

//获得用户信息
+(void)getAccountInfo:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;


///－－－－－－－－－－第三方登陆----------------

//oauth
+(void)wxOauth:(NSString*)url withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;

//验证信息
+(void)wxInfor:(NSString*)url withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;

//bind后login
+(void)wxBindLogin:(NSString*)encryptUID withThirdPlatform:(NSString*)thirdPlatform withuid:(NSString*)uid withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;;


//验证信息
+(void)weiboInfor:(NSString*)url withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;;

//bind后login
+(void)weiboBindLogin:(NSString*)encryptUID withThirdPlatform:(NSString*)thirdPlatform withuid:(NSString*)uid withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;;

//第三方登陆
+(void)weiboAndWeiXiLogin:(NSString*)uid withProfileUrl:(NSString*)profileUrl withGender:(NSString*)gender withDisplayName:(NSString*)displayName withThirdPlatform:(NSString*)thirdPlatform withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;;





//获得帐号是否绑定
+(void)isWeiboAndWeiXiBind:(NSString*)type withUnionId:(NSString*)unionId withOpenId:(NSString*)openId wihNickName:(NSString*)nickName withProfileUrl:(NSString*)profileUrl withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;


//新帐号绑定
+(void)weiboAndWeiXiBindForAccount:(NSString *)uid withProfileUrl:(NSString *)profileUrl withGender:(NSString *)gender withUnionId:(NSString*)unionId withMsCode:(NSString*)msCode withPhone:(NSString*)phone withDisplayName:(NSString *)displayName withThirdPlatform:(NSString *)thirdPlatform withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;

//已有账户绑定
+(void)weiboAndWeixiBind:(NSString *)uid withPhone:(NSString*)phone withPassword:(NSString *)password withGender:(NSString *)gender withThirdPlatform:(NSString *)thirdPlatform withUnionId:(NSString*)unionId withDisplayName:(NSString *)displayName withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;


//------------------End-------------


//个人中心绑定
+(void)personalWxAndWbBind:(NSString *)displayName withUnionId:(NSString*)unionId withOpenId:(NSString*)openId withThirdPlatform:(NSString*)thirdPlatform withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;


//登陆
+(void)authentication:(NSString*)phoneNum withPassword:(NSString*)password withSmsCode:(NSString*)smsCode withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;


//发送验证码
+(void)sendSMSCode:(NSString*)phoneNum withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;

//注册，提交验证码
+(void)submitCheckCode:(NSString*)phoneNum withSmsCode:(NSString*)smsCode withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;

//验证码，忘记密码
+(void)sendSMSCodeForResetPwd:(NSString*)phoneNum withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;

//忘记密码提交
+(void)checkSmsCode:(NSString*)phoneNum withSmsCode:(NSString*)smsCode withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;

//重设密码
+(void)resetPassword:(NSString*)phoneNum withPassword:(NSString*)password withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;
//注册设置密码
+(void)regiserResetPassword:(NSString*)phoneNum withPassword:(NSString*)password withHandler:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;


//刷新token
+(void)refreshToken:(requestSuccessBlock)handler withRequestFailBlock:(requestFailureBlock)failRequestBlock;

//获取服务器时间
+(void)getServiceTime:(requestSuccessBlock)handler withdeviceId:(NSString*)deviceId withRequestFailBlock:(requestFailureBlock)failRequestBlock;

/**
 *
 *
 *  @param registrationId 推送注册id
 *  @param handler
 *  @param failHandler
 */
+(void)jPushRegistrationId:(NSString*)registrationId withdeviceId:(NSString*)deviceId withHandler:(requestSuccessBlock)handler withHandler:(requestFailureBlock)failHandler;




@end

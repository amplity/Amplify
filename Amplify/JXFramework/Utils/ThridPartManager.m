//
//  ThridPartManager.m
//  Makeup
//
//  Created by Woody Yan on 10/22/14.
//  Copyright (c) 2014 Woody Yan. All rights reserved.
//

#import "ThridPartManager.h"
//#import "UserInfoManager.h"
#import "AppDelegate.h"
#import "BaseViewController.h"
#import "UserManager.h"


#import "LoginService.h"
#import "PerfectInfoViewController.h"

//#import "MainViewViewController.h"
#import "LoginBind.h"


@interface ThridPartManager ()  

@end

@implementation ThridPartManager


+ (ThridPartManager *) manager
{
    static ThridPartManager *_manager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _manager = [[ThridPartManager alloc] init];
    });
    return _manager;
}

//是否安装了微信
-(BOOL)isWeixinInstall{
    
    return [WXApi isWXAppInstalled];
}

-(BOOL)isQQInstall{
    return [TencentOAuth iphoneQQInstalled];
}

//微信登录
-(void)weixinLogin:(UIViewController*)dissViewController withPresentViewController:(BaseViewController *)presentViewController{
    //例如wx的登录
    
    
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             NSLog(@"UnionId=%@",[user.rawData objectForKey:@"unionid"]);
             
             
             LoginBind * loginBind = [[LoginBind alloc] init];
             loginBind.uid = user.uid;
             loginBind.profileUrl = user.icon;
             loginBind.nickname = user.nickname;
             loginBind.unionId = [user.rawData objectForKey:@"unionid"];
             loginBind.thirdPlatform = @"2";
             
             
             
             NSString *gender = [NSString stringWithFormat:@"%lu",(unsigned long)user.gender];
             if ([gender isEqualToString:@"1"]) {
                 gender = @"m";
             } else {
                 gender = @"f";
             }
             
             
             
             //判断是否绑定
             [LoginService isWeiboAndWeiXiBind:loginBind.thirdPlatform withUnionId:loginBind.unionId withOpenId:loginBind.uid wihNickName:loginBind.nickname withProfileUrl:loginBind.profileUrl withHandler:^(id responseObj) {
                 NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
                 NSDictionary * responseBody = [responseObj objectForKey:@"responseBody"];
                 if([[responseHead objectForKey:@"code"] isEqualToString:@"00000"]){
                     
                     NSString *isBindStr = [responseBody objectForKey:@"isbind"];
                     BOOL isBind = isBindStr.intValue==1 ? YES : NO;
                     
                     
                     //保存是否被邀请了
                     NSString *haveWishId =[responseBody objectForKey:@"haveWish"];
                     BOOL haveWish = haveWishId.intValue == 1 ? YES : NO;
                     
                     if (haveWish &&![UserManager firstInviteWish]) {
                         [UserManager saveFirstInviteWish:YES];
                     }
                     [UserManager saveInviteWish:haveWish];
                     
                     if (isBind) {//已经绑定了，直接进入app
                         [UserManager saveLogin];
                         [UserManager saveToken:[responseHead objectForKey:@"token"]];
                         
                         [presentViewController.navigationController popViewControllerAnimated:YES];
                     }else{
                         PerfectInfoViewController * perfectInfoViewController = [[PerfectInfoViewController alloc] init];
                         
                         perfectInfoViewController.inputViewData = loginBind;
                         [presentViewController.navigationController pushViewController:perfectInfoViewController animated:YES];
                     }
                     
                 }else{
                     [TipManager showTipsWithInforStr:[responseHead objectForKey:@"msg"] withAfter:1.0];
                 }

             } withRequestFailBlock:^(NSError *error) {
                 
             }];
         }else{
             NSLog(@"%@",error);
         }
         
     }];
}


-(void)weixinLoginPersonBind:(UIViewController *)presentViewController{
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             
             LoginBind * loginBind = [[LoginBind alloc] init];
             loginBind.uid = user.uid;
             loginBind.profileUrl = user.icon;
             loginBind.nickname = user.nickname;
             loginBind.unionId = [user.rawData objectForKey:@"unionid"];
             loginBind.thirdPlatform = @"2";
             
             
             
             NSString *gender = [NSString stringWithFormat:@"%lu",(unsigned long)user.gender];
             if ([gender isEqualToString:@"1"]) {
                 gender = @"m";
             } else {
                 gender = @"f";
             }
             
             
             //绑定
             
             [LoginService personalWxAndWbBind:loginBind.nickname withUnionId:loginBind.unionId withOpenId:loginBind.uid withThirdPlatform:loginBind.thirdPlatform withHandler:^(id responseObj) {
                 NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
                 if([[responseHead objectForKey:@"code"] isEqualToString:@"00000"]){
                     [TipManager showTipsWithInforStr:[responseHead objectForKey:@"msg"] withAfter:1.0];
                     
                     //通知
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_RefreshPersonal_info"
                                                                         object:nil];
                     
                 }else{
                     [TipManager showTipsWithInforStr:[responseHead objectForKey:@"msg"] withAfter:1.0];
                 }
             } withRequestFailBlock:^(NSError *error) {
                 
             }];
             
             
         }else{
             NSLog(@"%@",error);
         }
         
     }];
}

//微博登录
-(void)weiboLogin:(UIViewController*)dissViewController withPresentViewController:(BaseViewController *)presentViewController{
    //例如sina的登录
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             NSLog(@"UnionId=%@",[user.rawData objectForKey:@"unionid"]);
             
             
             LoginBind * loginBind = [[LoginBind alloc] init];
             loginBind.uid = user.uid;
             loginBind.profileUrl = user.icon;
             loginBind.nickname = user.nickname;
             loginBind.unionId = @"";
             loginBind.thirdPlatform = @"1";
             
             
             
             NSString *gender = [NSString stringWithFormat:@"%lu",(unsigned long)user.gender];
             if ([gender isEqualToString:@"1"]) {
                 gender = @"m";
             } else {
                 gender = @"f";
             }
             

             
             
             
             
             
             
             //判断是否绑定
             
             [LoginService isWeiboAndWeiXiBind:loginBind.thirdPlatform withUnionId:loginBind.unionId withOpenId:loginBind.uid wihNickName:loginBind.nickname withProfileUrl:loginBind.profileUrl withHandler:^(id responseObj) {
                 NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
                 NSDictionary * responseBody = [responseObj objectForKey:@"responseBody"];
                 if([[responseHead objectForKey:@"code"] isEqualToString:@"00000"]){
                     
                     NSString *isBindStr = [responseBody objectForKey:@"isbind"];
                     BOOL isBind = isBindStr.intValue==1 ? YES : NO;
                     
                     //保存是否被邀请了
                     NSString *haveWishId =[responseBody objectForKey:@"haveWish"];
                     BOOL haveWish = haveWishId.intValue == 1 ? YES : NO;
                     
                     if (haveWish &&![UserManager firstInviteWish]) {
                         [UserManager saveFirstInviteWish:YES];
                     }
                     [UserManager saveInviteWish:haveWish];
                     
                     if (isBind) {//已经绑定了，直接进入app
                         
                         [UserManager saveLogin];
                         [UserManager saveToken:[responseHead objectForKey:@"token"]];
                         [presentViewController.navigationController popViewControllerAnimated:YES];
                     }else{
                         PerfectInfoViewController * perfectInfoViewController = [[PerfectInfoViewController alloc] init];
                         
                         perfectInfoViewController.inputViewData = loginBind;
                         [presentViewController.navigationController pushViewController:perfectInfoViewController animated:YES];
                     }
                     
                 }
             } withRequestFailBlock:^(NSError *error) {
                 
             }];

         }
     
         else
         {
             NSLog(@"%@",error);
         }
     
     }];
}


-(void)weiboLoginPersonBind:(UIViewController *)presentViewController{
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             LoginBind * loginBind = [[LoginBind alloc] init];
             loginBind.uid = user.uid;
             loginBind.profileUrl = user.icon;
             loginBind.nickname = user.nickname;
             loginBind.unionId = @"";
             loginBind.thirdPlatform = @"1";
             
             
             
             NSString *gender = [NSString stringWithFormat:@"%lu",(unsigned long)user.gender];
             if ([gender isEqualToString:@"1"]) {
                 gender = @"m";
             } else {
                 gender = @"f";
             }

             //判断是否绑定
             
             [LoginService personalWxAndWbBind:loginBind.nickname withUnionId:loginBind.unionId withOpenId:loginBind.uid withThirdPlatform:loginBind.thirdPlatform withHandler:^(id responseObj) {
                 NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
                 if([[responseHead objectForKey:@"code"] isEqualToString:@"00000"]){
                     [TipManager showTipsWithInforStr:[responseHead objectForKey:@"msg"] withAfter:1.0];
                     
                     //通知
                     [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_RefreshPersonal_info"
                                                                         object:nil];
                 }else{
                     [TipManager showTipsWithInforStr:[responseHead objectForKey:@"msg"] withAfter:1.0];
                 }
             } withRequestFailBlock:^(NSError *error) {
                 
             }];
             
         }
         
     }];
}

//微信分享
-(void)weixinShare:(NSString*)title withInfoStr:(NSString*)info withIcon:(NSString*)Icon withUrl:(NSString*)url{
    //1、创建分享参数
    NSArray* imageArray = @[Icon];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:info
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:title
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK share:SSDKPlatformTypeWechat parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
                case SSDKResponseStateCancel:
                    DLog(@"分享取消");
                    break;
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:@""
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    DLog(@"%@",[NSString stringWithFormat:@"%@",error]);
                    break;
                }
                    
                    
                default:
                    break;
            }
        }];
    }

}

//微信朋友圈分享
-(void)weixinQunShare:(NSString*)title withInfoStr:(NSString*)info withIcon:(NSString*)Icon withUrl:(NSString*)url{
    //1、创建分享参数
//    NSArray* imageArray = @[[UIImage imageNamed:@"share_platform_wechattimeline"]];
    NSArray* imageArray = @[Icon];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:info
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:title
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
                case SSDKResponseStateCancel:
                    DLog(@"分享取消");
                    break;
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:@""
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    DLog(@"%@",[NSString stringWithFormat:@"%@",error]);
                    break;
                }
                    
                    
                default:
                    break;
            }
        }];
    }
}

//微博分享
-(void)weboShare:(NSString*)title withInfoStr:(NSString*)info withIcon:(NSString*)Icon withUrl:(NSString*)url{
    //1、创建分享参数
    
    NSURL *imageUrl = [NSURL URLWithString:Icon];
    UIImage * urlImage =[UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    NSArray* imageArray = @[urlImage];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        
        if (info.length>50) {
            info = [info substringToIndex:50];
        }
        
        
//        [shareParams SSDKSetupShareParamsByText:info
//                                         images:imageArray
//                                            url:[NSURL URLWithString:url]
//                                          title:title
//                                           type:SSDKContentTypeWebPage];
        
        
        // 定制新浪微博的分享内容
        [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@%@",info,url]
                                                   title:title
                                                   image:urlImage
                                                     url:[NSURL URLWithString:url]
                                                latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
        
        
        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
                case SSDKResponseStateCancel:
                    DLog(@"分享取消");
                    break;
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:@""
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    DLog(@"%@",[NSString stringWithFormat:@"%@",error]);
                    break;
                }
                    
                    
                default:
                    break;
            }
        }];
    }


}

-(void)qqShare:(NSString*)title withInfoStr:(NSString*)info withIcon:(NSString*)Icon withUrl:(NSString*)url{
    //1、创建分享参数
    NSArray* imageArray = @[Icon];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:info
                                         images:imageArray
                                            url:[NSURL URLWithString:url]
                                          title:title
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK share:SSDKPlatformSubTypeQQFriend parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
                case SSDKResponseStateCancel:
                    DLog(@"分享取消");
                    break;
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:@""
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    DLog(@"%@",[NSString stringWithFormat:@"%@",error]);
                    break;
                }
                    
                    
                default:
                    break;
            }
        }];
    }
}


@end

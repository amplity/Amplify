//
//  BaseWebControllerManager.m
//  Amplify
//
//  Created by ZhangJixu on 16/5/20.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseWebControllerManager.h"
#import "BaseWebManager.h"
#import "LinkModel.h"
#import "LinkManage.h"
#import "PersonalUrlModel.h"
#import "SettingViewController.h"
#import "DiscoverInfoViewController.h"
#import "PersonalInfoViewController.h"
#import "ShareModel.h"
#import "LookForShareFrameView.h"
#import "LoginViewController.h"
#import "AriticleInfoViewController.h"
#import "MoviePlayerViewController.h"
#import "WishInfoViewController.h"
#import "WishService.h"
#import "SettlementViewController.h"
#import "PersonalService.h"
#import "SettlementModel.h"
#import "PayChangeWebViewLoadViewController.h"
#import "HomTabBarController.h"
#import "DiscoverNoBarWebController.h"
#import "DiscoveryService.h"
#import "Pingpp.h"
#import "PayResultWeViewController.h"
#import "SearchViewController.h"
//美恰
#import "MQChatViewManager.h"

@implementation BaseWebControllerManager


+ (instancetype)shareWebManager {
    static BaseWebControllerManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BaseWebControllerManager alloc] init];
    });

    return instance;
}


- (void)pushControllerForJsObject:(BaseViewController *)baseViewController withBaseWebView:(UIWebView *)baseWebView {
    BaseWebView *currentWebView = (BaseWebView *) baseWebView;
    //滚动展示
    __weak typeof(self) weakSelf = self;

    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"$m_app_getUrl" withWebView:currentWebView withBlock:^(id jsToObject) {

        NSArray *jsObjectArr = (NSArray *) jsToObject;

        if (jsObjectArr.count > 0) {
            NSString *keyStr = [jsObjectArr objectAtIndex:0];

            //-------发现页------
            if ([keyStr isEqualToString:@"visitUrl"]) {//发现首页各种连接
                LinkModel *linkModel = [[LinkModel alloc] init];
                linkModel.url = [jsToObject objectAtIndex:1];
                linkModel.type = [jsToObject objectAtIndex:2];
                if (linkModel.type.intValue == LinkCategory) {
                    linkModel.titleStr = [jsToObject objectAtIndex:3];
                }


                [[LinkManage shareInstance] showWebViewByType:linkModel withOrigin:baseViewController];
            }
            else if ([keyStr isEqualToString:@"searchProduct"]) {//发现搜索
                dispatch_async(dispatch_get_main_queue(), ^{
                    SearchViewController *searchViewController = [[SearchViewController alloc] init];
                    searchViewController.inputViewData = @"/search";
                    [baseViewController.navigationController pushViewController:searchViewController animated:NO];
                });

            }
             else if ([keyStr isEqualToString:@"getparam1"]) {//购物车
                NSArray *args = (NSArray *) jsToObject;


                NSString *settlementVIewUrl = args[1];

                NSString *goodNumber = [args objectAtIndex:args.count - 1];


                if (goodNumber.intValue > 0) {


                    dispatch_async(dispatch_get_main_queue(), ^{
                        SettlementViewController *settlementViewController = [[SettlementViewController alloc] init];
                        settlementViewController.inputViewData = settlementVIewUrl;

                        [baseViewController.navigationController pushViewController:settlementViewController animated:YES];
                    });

                } else {

                    [TipManager showTipsWithInforStr:@"请选择商品" withAfter:1.0];
                }

            }else if ([keyStr isEqualToString:@"getIndex"]) {//购物车,继续购物
                NSArray *args = (NSArray *) jsToObject;
                NSString *goodListUrl = [args objectAtIndex:1];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSUInteger homTabBarSelectedIndex = [[HomTabBarController shareInstance] selectedIndex];
                    
                    if (homTabBarSelectedIndex==0) {
                        [baseViewController.navigationController popToRootViewControllerAnimated:YES];
                    }else{
                        [[HomTabBarController shareInstance] changeBarViewController:@"0"];
                    }
                });
                
                
            
            }else if ([keyStr isEqualToString:@"submitorder"]) {
                NSArray *args = (NSArray *) jsToObject;
                NSString *addressId = [args objectAtIndex:1];
                [self sendBtnClick:addressId withBaseVievController:baseViewController];
            } else if ([keyStr isEqualToString:@"brandDetail"]) {//商品详情,详情
                NSArray *valueDatas = jsToObject;

                NSString *brandUrl = [valueDatas objectAtIndex:1];
                LinkModel *linkModel = [[LinkModel alloc] init];
                linkModel.url = brandUrl;
                dispatch_async(dispatch_get_main_queue(), ^{
                    DiscoverNoBarWebController *discoverNoBarWebController = [[DiscoverNoBarWebController alloc] init];
                    discoverNoBarWebController.inputViewData = linkModel;
                    [baseViewController.navigationController pushViewController:discoverNoBarWebController animated:YES];
                });
            } else if ([keyStr isEqualToString:@"paytype"]) {//支付
                NSMutableArray *jsArray = jsToObject;

                NSString *orderId = [jsArray objectAtIndex:1];
                NSString *cashChannel = [jsArray objectAtIndex:2];


                [DiscoveryService payChangeForSend:orderId withCashChannel:cashChannel withHandler:^(id responseObj) {

                    NSDictionary *responseHead = [responseObj objectForKey:@"responseHead"];

                    NSDictionary *responseBody = [responseObj objectForKey:@"responseBody"];

                    if ([[responseHead objectForKey:@"code"] isEqualToString:@"00000"]) {


                        NSString *urlScheme;
                        if ([[responseHead objectForKey:@"msg"] isEqualToString:@"RMB"]) {
                            if ([cashChannel isEqualToString:@"alipay"]) {
                                urlScheme = ZfbId;
                            } else if ([cashChannel isEqualToString:@"wx"]) {
                                urlScheme = WeChatID;
                            } else if ([cashChannel isEqualToString:@"alipayHK"]) {
                                urlScheme = AlipayHK;
                            }


                            if ([cashChannel isEqualToString:@"alipayHK"]) {//海外支付
                                AlipayModel *alipayModel = [AlipayModel mj_objectWithKeyValues:[responseBody objectForKey:@"payParams"]];
                                alipayModel.orderId = [responseBody objectForKey:@"orderId"];

//                                NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:@"/app/alipaynotify" withParameter:nil];
//                                alipayModel.notify_url = comUrl;

                                PayChangeWebViewLoadViewController *payChangeWebViewLoadView = (PayChangeWebViewLoadViewController *) baseViewController;
                                [AliPayHelper helper].alipayHKDelegate = payChangeWebViewLoadView;
                                [[AliPayHelper helper] pay:alipayModel];
                            } else {//以下是ping++支付
                                [Pingpp createPayment:[responseBody objectForKey:@"charge"] appURLScheme:urlScheme withCompletion:^(NSString *result, PingppError *error) {

                                    if ([result isEqualToString:@"success"]) {
                                        // 支付成功
                                        PayResultWeViewController *resultWebViewController = [[PayResultWeViewController alloc] init];
                                        resultWebViewController.inputViewData = [NSString stringWithFormat:@"/app/payment?orderId=%@", [responseBody objectForKey:@"orderId"]];

                                        [baseViewController.navigationController pushViewController:resultWebViewController animated:YES];

                                    } else {
                                        // 支付失败或取消
                                        DLog(@"PingppError: code=%lu msg=%@", (unsigned long) error.code, [error getMsg]);
                                    }
                                }];
                            }


                        } else {
                            //积分支付

                            if ([responseHead objectForKey:@"msg"] && ![[responseHead objectForKey:@"msg"] isEqualToString:@""]) {
                                //积分支付成功
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付提示" message:@"支付成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];

                                [alertView show];
                            } else {
                                //积分支付失败
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付提示" message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];

                                [alertView show];
                            }
                        }
                    } else {
                        DLog(@"error%@", [responseHead objectForKey:@"msg"]);
                    }


                }                      withHandler:^(NSError *error) {

                }];
            }

                //-------------------物色------------------
            else if ([keyStr isEqualToString:@"getArticleMsg"]) {
                NSArray *valueDatas = jsToObject;

                NSString *type = [valueDatas objectAtIndex:2];
                if (type.integerValue == 1) {
                    AriticleInfoViewController *ariticleInfoViewController = [[AriticleInfoViewController alloc] init];
                    ariticleInfoViewController.inputViewData = [valueDatas objectAtIndex:1];


                    dispatch_async(dispatch_get_main_queue(), ^{
                        [baseViewController.navigationController pushViewController:ariticleInfoViewController animated:YES];
                    });

                } else {
                    AriticleInfoViewController *ariticleInfoViewController = [[AriticleInfoViewController alloc] init];
                    ariticleInfoViewController.inputViewData = [valueDatas objectAtIndex:1];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [baseViewController.navigationController pushViewController:ariticleInfoViewController animated:YES];
                    });
                }

            } else if ([keyStr isEqualToString:@"playVideo"]) {
                NSString *titleStr = [jsToObject objectAtIndex:2];//标题
                NSString *movieUrl = [jsToObject objectAtIndex:1];

                dispatch_async(dispatch_get_main_queue(), ^{

                    MoviePlayerViewController *movie = [[MoviePlayerViewController alloc] init];
                    __weak typeof(movie) weakMovie = movie;


                    NSString *urlName = movieUrl;
                    urlName = [urlName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    weakMovie.url = urlName;
                    weakMovie.danmaku = @"";
                    weakMovie.titleStr = titleStr;
                    if (baseViewController.presentedViewController == nil) {

                        [baseViewController presentViewController:movie animated:NO completion:nil];
                    }

                });

            }


                //------------个人中心--------
            else if ([keyStr isEqualToString:@"getVisitLink"]) {//个人首页各种连接
                PersonalUrlModel *personUrlModel = [[PersonalUrlModel alloc] init];
                personUrlModel.type = [jsToObject objectAtIndex:2];
                personUrlModel.personalUrl = [jsToObject objectAtIndex:1];

                [self pushWebViewForType:personUrlModel withOrigin:baseViewController];
            } else if ([keyStr isEqualToString:@"getSet"]) {//设置
                dispatch_async(dispatch_get_main_queue(), ^{
                    SettingViewController *settingViewController = [[SettingViewController alloc] init];
                    [baseViewController.navigationController pushViewController:settingViewController animated:YES];
                });

            } else if ([keyStr isEqualToString:@"brandDetail"]) {//关注的品牌
                NSString *ganZhuUrl = [jsToObject objectAtIndex:1];
            } else if ([keyStr isEqualToString:@"productDetail"]) {//商品详情页
                LinkModel *linkModel = [[LinkModel alloc] init];
                linkModel.url = [jsToObject objectAtIndex:1];

                dispatch_async(dispatch_get_main_queue(), ^{
                    DiscoverInfoViewController *discoverInfoViewController = [[DiscoverInfoViewController alloc] init];
                    discoverInfoViewController.inputViewData = linkModel;
                    [baseViewController.navigationController pushViewController:discoverInfoViewController animated:YES];
                });

            } else if ([keyStr isEqualToString:@"getMsg"]) {
                LinkModel *linkModel = [[LinkModel alloc] init];
                linkModel.url = [jsToObject objectAtIndex:1];

                dispatch_async(dispatch_get_main_queue(), ^{
                    DiscoverNoBarWebController *discoverNoBarWebController = [[DiscoverNoBarWebController alloc] init];
                    discoverNoBarWebController.inputViewData = linkModel;
                    [baseViewController.navigationController pushViewController:discoverNoBarWebController animated:YES];
                });

            } else if ([keyStr isEqualToString:@"goPay"]) {
                NSString *payChangeUrl = [jsToObject objectAtIndex:1];
                dispatch_async(dispatch_get_main_queue(), ^{
                    PayChangeWebViewLoadViewController *payChangeWebViewLoadViewController = [[PayChangeWebViewLoadViewController alloc] init];
                    payChangeWebViewLoadViewController.inputViewData = payChangeUrl;
                    [baseViewController.navigationController pushViewController:payChangeWebViewLoadViewController animated:YES];
                });
            } else if ([keyStr isEqualToString:@"backMe"]) {
                HomTabBarController *homTabBarController = [HomTabBarController shareInstance];
                [homTabBarController setSelectedIndex:homTabBarController.viewControllers.count - 1];
            }


                //-----------个人中心详情-----
            else if ([keyStr isEqualToString:@"backevent"]) {//返回
                dispatch_async(dispatch_get_main_queue(), ^{
                    [baseViewController.navigationController popViewControllerAnimated:YES];
                });
            }

                //-----------物色页-----
            else if ([keyStr isEqualToString:@"shareArticle"]) {//分享
                ShareModel *shareModel = [[ShareModel alloc] init];
                shareModel.businessId = [jsToObject objectAtIndex:1];


                if ([UserManager isLogin]) {
                    dispatch_async(dispatch_get_main_queue(), ^{

                        LookForShareFrameView *lookForShareFrameView = [LookForShareFrameView instancesViewWithBaseModel:shareModel];
                        lookForShareFrameView.baseViewDelegate = baseViewController;
                        [baseViewController.view.window addSubview:lookForShareFrameView];

                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        LoginViewController *loginViewController = [LoginViewController alloc];
                        loginViewController.loginRestltDelegate = baseViewController;
                        [baseViewController.navigationController pushViewController:loginViewController animated:YES];
                    });

                }

            }else if ([keyStr isEqualToString:@"wxBind"]) {//微信绑定
                
                
                [[ThridPartManager manager] weixinLoginPersonBind:baseViewController];
                
            }else if ([keyStr isEqualToString:@"sinaBind"]) {//新浪绑定
                [[ThridPartManager manager] weiboLoginPersonBind:baseViewController];
            }


                //-------------------心愿------------
            else if ([keyStr isEqualToString:@"wishDetail"]) {
                NSString *wishInfoUrl = [jsToObject objectAtIndex:1];

                dispatch_async(dispatch_get_main_queue(), ^{
                    WishInfoViewController *wishInfoViewController = [[WishInfoViewController alloc] init];
                    wishInfoViewController.inputViewData = wishInfoUrl;
                    [baseViewController.navigationController pushViewController:wishInfoViewController animated:YES];
                });
            } else if ([keyStr isEqualToString:@"remindMe"]) {
                NSString *paramUrl = [jsToObject objectAtIndex:1];
                NSString *paramStr = [jsToObject objectAtIndex:2];

                [WishService remindme:paramStr withHandler:^(id responseObj) {
                    NSDictionary *remindMeHead = [responseObj objectForKey:@"responseHead"];
                    if ([[remindMeHead objectForKey:@"code"] isEqualToString:@"00000"]) {//成功
                        [JXAlertViewManage showViewWithAlert:@"提示" withInfo:@"提醒成功!" withStatus:@""];
                    }
                }         withHandler:^(NSError *error) {
                    
                }];

            } else if ([keyStr isEqualToString:@"detail"]) {
                NSString *wishInfoUrl = [jsToObject objectAtIndex:1];
                WishInfoViewController *wishInfoViewController = [[WishInfoViewController alloc] init];
                wishInfoViewController.inputViewData = wishInfoUrl;
                [baseViewController.navigationController pushViewController:wishInfoViewController animated:YES];
            }


                //--------启动页-------------
            else if ([keyStr isEqualToString:@"appJump"]) {
                HomTabBarController *homTabBarController = [HomTabBarController shareInstance];
                [baseViewController presentViewController:homTabBarController animated:YES completion:nil];
            }
            
            // --------美恰 ----------
            else if ([keyStr isEqualToString:@"getMeiqia"]) {
                MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
                [chatViewManager pushMQChatViewControllerInViewController:baseViewController];
            }

        }


    }];
}

//跳转
- (void)pushWebViewForType:(PersonalUrlModel *)personalUrlModel withOrigin:(BaseViewController *)baseViewController {

    dispatch_async(dispatch_get_main_queue(), ^{

        if ([personalUrlModel.type isEqualToString:@"7"] && [NSStringFromClass([baseViewController class]) isEqualToString:@"PersonalInfoViewController"]) {

            BaseWebViewController *guzhuWebViewController = (BaseWebViewController *) baseViewController;

            NSString *comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:personalUrlModel.personalUrl withParameter:nil];

            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:comUrl]];


            //2.创建一个 NSMutableURLRequest 添加 header
            NSMutableURLRequest *mutableRequest = [request mutableCopy];
            NSString *tonken = [UserManager token];
            [mutableRequest addValue:tonken forHTTPHeaderField:@"token"];

            [guzhuWebViewController.baseWebView loadRequest:mutableRequest];

        } else {
            PersonalInfoViewController *personalInfoViewController = [[PersonalInfoViewController alloc] init];
            personalInfoViewController.inputViewData = personalUrlModel;
            [baseViewController.navigationController pushViewController:personalInfoViewController animated:YES];

        }
    });
}

// 订单详情页 提交订单方法
- (void)sendBtnClick:(NSString *)addressId withBaseVievController:(UIViewController *)baseViewController {
    //提交订单
    NSString *weiXinStr = [[ThridPartManager manager] isWeixinInstall] ? @"1" : @"0";

    [PersonalService paySend:addressId withType:@"1" withStatus:weiXinStr withHandler:^(id responseObj) {
        SettlementModel *settlementModel = [SettlementModel mj_objectWithKeyValues:responseObj];
        if ([settlementModel.responseHead.code isEqualToString:@"00000"]) {
            NSString *url = settlementModel.responseBody.url;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                PayChangeWebViewLoadViewController *payChangeWebViewLoadViewController = [[PayChangeWebViewLoadViewController alloc] init];
                payChangeWebViewLoadViewController.inputViewData = url;
                [baseViewController.navigationController pushViewController:payChangeWebViewLoadViewController animated:YES];
            });
        } else {
            
            if (settlementModel.responseHead.error && ![settlementModel.responseHead.error isEqualToString:@""]) {
                [TipManager showTipsWithInforStr:settlementModel.responseHead.error withAfter:1.0];
            }
            if (settlementModel.responseHead.msg && ![settlementModel.responseHead.msg isEqualToString:@""]) {
                [TipManager showTipsWithInforStr:settlementModel.responseHead.msg withAfter:1.0];
            }
            
        }
    } withHandler:^(NSError *error) {
        [TipManager showTipsWithInforStr:error.localizedDescription withAfter:1.0];
    }];
    
    
//    BOOL isWeixinInstall = [[ThridPartManager manager] isWeixinInstall];
//    
//    NSString * weixinStr = isWeixinInstall ? @"1" : @"0";
//    
//    [PersonalService paySend:addressId withType:@"1" withStatus:weixinStr withHandler:^(id responseObj) {
//        UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT)];
//        
//        UILabel * infoLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//        
//        [bgView addSubview:infoLab];
//        
//        [baseViewController.view.window addSubview:bgView];
//        
//        
//        
//        SettlementModel *settlementModel = [SettlementModel mj_objectWithKeyValues:responseObj];
//        
//        infoLab.text = [NSString stringWithFormat:@"%@基数数据SettlementModel==%@",responseObj,settlementModel];
//        
//        
//        
//        if ([settlementModel.responseHead.code isEqualToString:@"00000"]) {
//            PayChangeWebViewLoadViewController * payChangeWebViewLoadViewController = [[PayChangeWebViewLoadViewController alloc] init];
//            payChangeWebViewLoadViewController.inputViewData = settlementModel.responseBody.url;
//            
//            [baseViewController.navigationController pushViewController:payChangeWebViewLoadViewController animated:YES];
//        }else{
//            [TipManager showTipsWithInforStr:settlementModel.responseHead.msg withAfter:1.0];
//        }
//
//    } withHandler:^(NSError *error) {
//        [TipManager showTipsWithInforStr:error.localizedDescription withAfter:1.0];
//    }];
    
}

@end

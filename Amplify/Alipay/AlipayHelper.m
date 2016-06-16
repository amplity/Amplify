//
//  AlipayHelper.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/12.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "AlipayHelper.h"
#import "Order.h"
#import "AlipayModel.h"
#import "DataSigner.h"
#import "DataVerifier.h"
#import "PayResultWeViewController.h"

@implementation AliPayHelper

+(AliPayHelper*)helper {
    static AliPayHelper *helper = NULL;
    if (!helper) {
        helper = [[AliPayHelper alloc] init];
    }
    return helper;
}


-(void)pay:(AlipayModel*)alipayModel{
   
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088221249105525";
    NSString *seller = @"payhk@harmay.com";
    NSString *privateKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAL6sGZZbQ/tfg7fO6YHEK2cvHy2C1GwGZxq+1nSnEDXTJ2uY///cFzxBPUBvDKjXQNbXQ+wbsH14jgaAlv0Eb0vVEuJClfNEJ5ZBx2SbTUlmEVHRJ1HqqMoKjAXZGbSCsTj/DsbPFg0g08Qo9V+Mfmn56XQYgOTjzkwjdjKOlXT7AgMBAAECgYEAvf6PoJtgqmMKxWWQmJX5CeCSmK79LIdUxfnTiHnQVVIKvdS/gxy0qn33ovUFEFktaucl72fH/b7bBu+rhIOewaEyibKdapP9xr3/nZh1B6Z6bJVHhZbMUqkH9g/Q+5eyr5fm2ZjXl2LXwWSEzmL86v8qboKKYmcEqDWb5pVBKcECQQDhfyV4ltJ4KBkAOcxHh5ODRlCyuYOvpKcQs2FNJBv4DllyovGBCYaz/anffoO8iF+YAOkOFmNNQVCp4R9c1m5dAkEA2Hb/2Z4rvIEX+f5i81OucIlilw8FdsBcGEGUjbAeKw35US+1UV5YWKSpPr7yPH0WyRCZqrLeORk7WTOerwDLNwJBALfmweB+4FcuHHWarYcIgr1k8xtPQJ5WYgm0wX3wHP9IdJqRWPQrmLfiAFBNFZMEhTGqTGc4yvOOeQKSnslP9+ECQCBENMUSj8Bsmc9Y/RT6T1FVGU4dHhpieBfhhqxMKWMPlS9l5ig34QFtohDJU8BygPf9snpAaWGngjI8wJWjj6cCQQDRhZdOeybCzXok6Psg+KGWHgRyfrtfpXZxwqDrIShVfjeH304ec9Cgvp3O2O+7IzHkU6E4qIScUcyTh/scrlbZ";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.service = @"mobile.securitypay.pay";
    order.partner = partner;
    order.inputCharset = @"utf-8";
    order.seller = seller;
    order.tradeNO = alipayModel.orderId; //订单ID（由商家自行制定）
    order.productName = alipayModel.subject; //商品标题
    order.productDescription = alipayModel.body; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",alipayModel.total_fee]; //商品价格
    order.notifyURL =  alipayModel.notify_url; //回调URL
    order.monneyType = alipayModel.currency;
    
    
    order.paymentType = @"1";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"alipaySdkHarmay";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            
            
            NSString* code = [resultDic objectForKey:@"resultStatus"];
            
            
            [self paymentResultDelegate:code withObject:alipayModel.orderId];
            
        }];
        
    }
}



-(void)paymentResultDelegate:(NSString *)result withObject:(id)obj{
    
    [self.alipayHKDelegate paymentResultDelegate:result withObject:obj];
}


@end

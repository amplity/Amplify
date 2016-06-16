//
//  AlipayHelper.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/12.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "AlipayModel.h"

static NSString * PartnerID = @"2088221249105525";
static NSString * SellerID = @"payhk@harmay.com";
static NSString * PartnerPrivKey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAL6sGZZbQ/tfg7fO6YHEK2cvHy2C1GwGZxq+1nSnEDXTJ2uY///cFzxBPUBvDKjXQNbXQ+wbsH14jgaAlv0Eb0vVEuJClfNEJ5ZBx2SbTUlmEVHRJ1HqqMoKjAXZGbSCsTj/DsbPFg0g08Qo9V+Mfmn56XQYgOTjzkwjdjKOlXT7AgMBAAECgYEAvf6PoJtgqmMKxWWQmJX5CeCSmK79LIdUxfnTiHnQVVIKvdS/gxy0qn33ovUFEFktaucl72fH/b7bBu+rhIOewaEyibKdapP9xr3/nZh1B6Z6bJVHhZbMUqkH9g/Q+5eyr5fm2ZjXl2LXwWSEzmL86v8qboKKYmcEqDWb5pVBKcECQQDhfyV4ltJ4KBkAOcxHh5ODRlCyuYOvpKcQs2FNJBv4DllyovGBCYaz/anffoO8iF+YAOkOFmNNQVCp4R9c1m5dAkEA2Hb/2Z4rvIEX+f5i81OucIlilw8FdsBcGEGUjbAeKw35US+1UV5YWKSpPr7yPH0WyRCZqrLeORk7WTOerwDLNwJBALfmweB+4FcuHHWarYcIgr1k8xtPQJ5WYgm0wX3wHP9IdJqRWPQrmLfiAFBNFZMEhTGqTGc4yvOOeQKSnslP9+ECQCBENMUSj8Bsmc9Y/RT6T1FVGU4dHhpieBfhhqxMKWMPlS9l5ig34QFtohDJU8BygPf9snpAaWGngjI8wJWjj6cCQQDRhZdOeybCzXok6Psg+KGWHgRyfrtfpXZxwqDrIShVfjeH304ec9Cgvp3O2O+7IzHkU6E4qIScUcyTh/scrlbZ";

//static NSString * PartnerPrivKey = @"ea7np5lqcuie06jdxw60lytp157gz7rw";
static NSString * AlipayPubKey = @"ea7np5lqcuie06jdxw60lytp157gz7rw";
static NSString * AppScheme = @"alipaySdkHarmay";



@protocol AlipayHKDelegate <NSObject>


-(void)paymentResultDelegate:(NSString *)result withObject:(id)obj;

@end

@interface AliPayHelper : NSObject <UIAlertViewDelegate>


@property (nonatomic) id<AlipayHKDelegate> alipayHKDelegate;

+(AliPayHelper*)helper;



-(void)pay:(AlipayModel*)alipayModel;


@end

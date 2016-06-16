//
//  APViewController.m
//  AliSDKDemo
//
//  Created by 方彬 on 11/29/13.
//  Copyright (c) 2013 Alipay.com. All rights reserved.
//

#import "APViewController.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "APAuthV2Info.h"

@implementation Product


@end

@interface APViewController ()

@end

@implementation APViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self generateData];
}


#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
	static int kNumber = 15;
	
	NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	NSMutableString *resultStr = [[NSMutableString alloc] init];
	srand(time(0));
	for (int i = 0; i < kNumber; i++)
	{
		unsigned index = rand() % [sourceStr length];
		NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
		[resultStr appendString:oneStr];
	}
	return resultStr;
}



#pragma mark -
#pragma mark   ==============产生订单信息==============

- (void)generateData{
	NSArray *subjects = @[@"1",
                          @"2",@"3",@"4",
                          @"5",@"6",@"7",
                          @"8",@"9",@"10"];
	NSArray *body = @[@"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据"];
	
	if (nil == self.productList) {
		self.productList = [[NSMutableArray alloc] init];
	}
	else {
		[self.productList removeAllObjects];
	}
    
	for (int i = 0; i < [subjects count]; ++i) {
		Product *product = [[Product alloc] init];
		product.subject = [subjects objectAtIndex:i];
		product.body = [body objectAtIndex:i];
        
		product.price = 0.01f+pow(10,i-2);
		[self.productList addObject:product];
	}
}


#pragma mark -
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 55.0f;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.productList count];
}




//
//用TableView呈现测试数据,外部商户不需要考虑
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
													reuseIdentifier:@"Cell"];
    
	Product *product = [self.productList objectAtIndex:indexPath.row];

    cell.textLabel.text = product.body;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"一口价：%.2f",product.price];
	
	return cell;
}


#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
//
//选中商品调用支付宝极简支付
//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

	/*
	 *点击获取prodcut实例并初始化订单信息
	 */
	Product *product = [self.productList objectAtIndex:indexPath.row];
	
	/*
	 *商户的唯一的parnter和seller。
	 *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
	 */
    
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
	order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
	order.productName = product.subject; //商品标题
	order.productDescription = product.body; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
	order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    
    order.paymentType = @"1";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
	
	//应用注册scheme,在AlixPayDemo-Info.plist定义URL types
	NSString *appScheme = @"alisdkdemo";
	
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
        }];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end

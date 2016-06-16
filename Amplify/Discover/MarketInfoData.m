//
//  MarketInfoData.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/11/26.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "MarketInfoData.h"

@implementation MarketInfoData


-(void)initResponseBodyDic:(NSDictionary *)responseBodyDic{
    NSString * stateStr = [responseBodyDic objectForKey:@"state"];
    self.state = [stateStr isEqualToString:@"1"] ? YES:NO;
    self.guanzhuNum = [responseBodyDic objectForKey:@"num"];
}
@end

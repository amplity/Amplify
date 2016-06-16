//
//  ShareManage.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/28.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "ShareManage.h"

@implementation ShareManage

+(instancetype)shareInstance{
    
    static ShareManage * shareManage;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManage = [[ShareManage alloc] init];
    });
    
    return  shareManage;
}

-(void)shareViewController:(BaseViewController*)viewController withParagmer:(id)paragmer{
    
}

@end

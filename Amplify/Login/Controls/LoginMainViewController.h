//
//  LoginMainViewController.h
//  Amplify
//
//  Created by 张吉旭 on 16/5/17.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginMainViewController : BaseViewController

@property (nonatomic, strong) id<LoginResultDelegate> loginRestltDelegate;


//登录，注册，记录的前操作的（NSting）
@property (nonatomic, strong) NSString *beforeOptionStr;

@end

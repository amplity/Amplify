//
//  LookForViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseViewController.h"

@interface LookForViewController : BaseViewController<UITabBarDelegate>
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet UIView *fourView;

@end

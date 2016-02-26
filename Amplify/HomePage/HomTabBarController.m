//
//  HomTabBarController.m
//  Amplify
//
//  Created by ZhangJixu on 16/1/26.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "HomTabBarController.h"
#import "HomeViewController.h"
#import "PersonalViewController.h"
#import "BaseNavigationController.h"


#import "LookForViewController.h"
#import "DiscoverViewController.h"
#import "WishViewController.h"
#import "PersonalViewController.h"

@interface HomTabBarController ()

@end

@implementation HomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    LookForViewController * lookForViewController = [[LookForViewController alloc] init];
    lookForViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"物色" image:[UIImage imageNamed:@"inter_def"]selectedImage:[UIImage imageNamed:@"inter_sel"]];
    lookForViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    lookForViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);


    BaseNavigationController * lookForNavigationController = [[BaseNavigationController alloc] initWithRootViewController:lookForViewController];

    
    
    DiscoverViewController * discoverViewController = [[DiscoverViewController alloc] init];
    discoverViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageNamed:@"discover_daf"]selectedImage:[UIImage imageNamed:@"discover_sel"]];
    discoverViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    discoverViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
    
    BaseNavigationController * discoverNavigationController = [[BaseNavigationController alloc] initWithRootViewController:discoverViewController];
    
    WishViewController * wishViewController = [[WishViewController alloc] init];
    wishViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"心愿" image:[UIImage imageNamed:@"shop_def"]selectedImage:[UIImage imageNamed:@"shop_sel"]];
    wishViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    wishViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
    
    BaseNavigationController * wishNavigationController = [[BaseNavigationController alloc] initWithRootViewController:wishViewController];
    
    PersonalViewController * personalViewController = [[PersonalViewController alloc] init];
    personalViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人" image:[UIImage imageNamed:@"person_def"]selectedImage:[UIImage imageNamed:@"person_sel"]];
    personalViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    personalViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
    
    BaseNavigationController * personalNavigationController = [[BaseNavigationController alloc] initWithRootViewController:personalViewController];
    
    self.viewControllers = [[NSArray alloc] initWithObjects:lookForNavigationController,discoverNavigationController,wishNavigationController, personalNavigationController,nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


@end

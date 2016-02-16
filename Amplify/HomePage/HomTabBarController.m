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

@interface HomTabBarController ()

@end

@implementation HomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    HomeViewController * homeViewController = [[HomeViewController alloc] init];
    homeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现频道" image:[UIImage imageNamed:@"discover_daf"]selectedImage:[UIImage imageNamed:@"discover_sel"]];
    homeViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    homeViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);

    BaseNavigationController * homeNavigationController = [[BaseNavigationController alloc] initWithRootViewController:homeViewController];
    
    
    PersonalViewController * personalViewController = [[PersonalViewController alloc] init];
    personalViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人设置" image:[UIImage imageNamed:@"person_def"]selectedImage:[UIImage imageNamed:@"person_sel"]];
    personalViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    personalViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(8, 0, -8, 0);
    
    BaseNavigationController * personalNavigationController = [[BaseNavigationController alloc] initWithRootViewController:personalViewController];
    
    self.viewControllers = [[NSArray alloc] initWithObjects:homeNavigationController, personalNavigationController,nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

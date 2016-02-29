//
//  AppDelegate.m
//  Amplify
//
//  Created by ZhangJixu on 16/1/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "HomTabBarController.h"
#import "BootViewController.h"
#import "ZYWContainerViewController.h"
#import "HomeInfoController.h"
#import "SlideNavigationController.h"
#import "LookForViewController.h"
#import <ViewDeck/ViewDeck.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupAppInit];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//白色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//黑色
    
    return YES;
}


-(void)setupAppInit{
    
    UIViewController * startViewController = nil;
    
    if (/* DISABLES CODE */ (1)) {

//        startViewController = [[ZYWContainerViewController alloc] init];
        
        IIViewDeckLeftController * iiViewDeckLeftController = [[HomeInfoController alloc] init];
        
        
        IIViewDeckController * iiViewDeckViewController = [[IIViewDeckController alloc] initWithCenterViewController:[[HomTabBarController alloc] init] leftViewController:iiViewDeckLeftController];
        
        iiViewDeckViewController.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
        
        startViewController = iiViewDeckViewController;
        
        
    }else{
        startViewController = [[BootViewController alloc] init];
    }
    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = startViewController;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

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


#import "PersonalViewController.h"
#import <ViewDeck/ViewDeck.h>

#import "HomeService.h"
#import "HomePageModel.h"

#import "DiscoveryViewController.h"
#import "LookForHomeViewController.h"
#import "LookForWebViewController.h"
#import "LookForWeb2ViewController.h"
#import "LookForWeb3ViewController.h"
#import "LookForWeb4ViewController.h"
#import "WishWebViewController.h"
#import "WishWeb2ViewController.h"
#import "WishWeb3ViewController.h"
#import "WishHomeViewController.h"
#import "BootWebViewController.h"
#import "ShopCartViewController.h"



@interface HomTabBarController (){
    NSMutableArray * homePageUrls;
}

@end

@implementation HomTabBarController

+(instancetype)shareInstance{
    
    static HomTabBarController * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HomTabBarController alloc] init];
    });
    
    return instance;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self initHomePageUrl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(execute:)
                                                 name:@"NOTIFICATION_NAME"
                                               object:nil];
    
    
}

- (void)execute:(NSNotification *)notification {
    //do something when received notification
    //notification.name is @"NOTIFICATION_NAME"
    //    if(notification.object && [notification.object isKindOfClass:[Test class]]){
    //                 //do something
    //    }
    
    if ([notification.name isEqualToString:@"NOTIFICATION_NAME"] ) {
        [self initUI:YES];
        //强制引导为心愿
        self.selectedIndex = 2;
    }
}


-(void)initHomePageUrl{
    
    [HomeService getHomePageUrl:^(id responseObj) {
        
        HomePageModel * homePageModel = [HomePageModel mj_objectWithKeyValues:responseObj];
        homePageUrls = [NSMutableArray array];
        
        [homePageUrls addObjectsFromArray:homePageModel.responseBody.urlList];
        
        //视频和生活置换，（1和3置换）
        NSString * moveUrlStr = homePageUrls[1];
        [homePageUrls removeObjectAtIndex:1];
        [homePageUrls insertObject:moveUrlStr atIndex:3];
        
        
        [self initUI:[UserManager inviteWish]];
        
    } withFail:^(NSError *error) {
        [self initUI:NO];
    }];
    
    
}

-(void)initUI:(BOOL)isInvite{
    self.tabBar.selectedImageTintColor = HexRGB(0xcc3333);
    
    
    LookForHomeViewController * lookForViewController = [[LookForHomeViewController alloc] initWithTitles:[NSArray arrayWithObjects:@"焦点",@"生活",@"研美",@"视频", nil] controllersClass:@[[LookForWebViewController class],[LookForWeb4ViewController class],[LookForWeb3ViewController class],[LookForWeb2ViewController class]] inputViewDatas:homePageUrls];
    
    NSString * normalImageStr = @"";
    NSString * selectImageStr = @"";
    if (isInvite) {
        normalImageStr = @"discoveryNo5";
        selectImageStr = @"discoverySe5";
        
    }else{
        normalImageStr = @"discoveryNo4";
        selectImageStr = @"discoverySe4";
    }
    UIImage *tabSelectImage = [UIImage imageNamed:selectImageStr];
    tabSelectImage = [tabSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    lookForViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:normalImageStr]selectedImage:tabSelectImage];
//    lookForViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    lookForViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    
    BaseNavigationController * lookForNavigationController = [[BaseNavigationController alloc] initWithRootViewController:lookForViewController];
    
    
    
    DiscoveryViewController * discoverViewController = [[DiscoveryViewController alloc] init];
    if (isInvite) {
        normalImageStr = @"shopNo5";
        selectImageStr = @"shopSe5";
        
    }else{
        normalImageStr = @"shopNo4";
        selectImageStr = @"shopSe4";
    }
    tabSelectImage = [UIImage imageNamed:selectImageStr];
    tabSelectImage = [tabSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discoverViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:normalImageStr]selectedImage:tabSelectImage];
//    discoverViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    discoverViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    BaseNavigationController * discoverNavigationController = [[BaseNavigationController alloc] initWithRootViewController:discoverViewController];

    
    
    WishHomeViewController * wishViewController = [[WishHomeViewController alloc] initWithTitles:@[@"本期活动",@"下期预告",@"往期活动"] controllersClass:@[[WishWebViewController class],[WishWeb2ViewController class],[WishWeb3ViewController class]] inputViewDatas:@[]];
    if (isInvite) {
        normalImageStr = @"wishNo5";
        selectImageStr = @"wishSe5";
    }
    
    //??????????测试用，后必须删掉
    
    else{
        normalImageStr = @"bagNo4";
        selectImageStr = @"bagSe4";
    }
    
    //end
    
    tabSelectImage = [UIImage imageNamed:selectImageStr];
    tabSelectImage = [tabSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    wishViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:normalImageStr]selectedImage:tabSelectImage];
//    wishViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    wishViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    BaseNavigationController * wishNavigationController = [[BaseNavigationController alloc] initWithRootViewController:wishViewController];

    
    //购物车
    ShopCartViewController * homeShopCartViewController = [[ShopCartViewController alloc] init];
    if (isInvite) {
        normalImageStr = @"bagNo5";
        selectImageStr = @"bagSe5";
    }else{
        normalImageStr = @"bagNo4";
        selectImageStr = @"bagSe4";
    }
    tabSelectImage = [UIImage imageNamed:selectImageStr];
    tabSelectImage = [tabSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeShopCartViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:normalImageStr]selectedImage:tabSelectImage];
    //    personalViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    homeShopCartViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    BaseNavigationController * shopCartNavigationController = [[BaseNavigationController alloc] initWithRootViewController:homeShopCartViewController];
    
    
    
    PersonalViewController * personalViewController = [[PersonalViewController alloc] init];
    if (isInvite) {
        normalImageStr = @"meNo5";
        selectImageStr = @"meSe5";
    }else{
        normalImageStr = @"meNo4";
        selectImageStr = @"meSe4";
    }
    tabSelectImage = [UIImage imageNamed:selectImageStr];
    tabSelectImage = [tabSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    personalViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:normalImageStr]selectedImage:tabSelectImage];
//    personalViewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    personalViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    
    BaseNavigationController * personalNavigationController = [[BaseNavigationController alloc] initWithRootViewController:personalViewController];
    

    if (isInvite) {
        self.viewControllers = [[NSArray alloc] initWithObjects:discoverNavigationController,lookForNavigationController,wishNavigationController, shopCartNavigationController,personalNavigationController,nil];
    }else{
        self.viewControllers = [[NSArray alloc] initWithObjects:discoverNavigationController,lookForNavigationController,shopCartNavigationController, personalNavigationController,nil];
    }
    
    //方便测试
//    self.viewControllers = [[NSArray alloc] initWithObjects:discoverNavigationController,lookForNavigationController,wishNavigationController,personalNavigationController,nil];
    
}


//设置选中
-(void)changeBarViewController:(NSString*)indexStr{
    
    self.selectedIndex = indexStr.intValue;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  设置左侧的tabBarItem
 */
-(UIBarButtonItem*)homeLeftTabBar{
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tab_qworld_press"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick:)];
    
    return leftBarButtonItem;
}


/**
 *  点击左上角，滑动左边视图
 *
 *  @param sender <#sender description#>
 */
-(void)leftBarButtonClick:(id)sender{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}


@end

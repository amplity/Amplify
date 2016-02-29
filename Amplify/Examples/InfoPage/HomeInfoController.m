//
//  HomeInfoController.m
//  Amplify
//
//  Created by ZhangJixu on 16/1/27.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "HomeInfoController.h"
#import "TestViewController.h"
#import "SwipePageViewController.h"
#import "BaseSearchViewController.h"
#import "KCMainViewController.h"
#import "DrogImageView.h"
#import "BasketBallViewController.h"
#import "TestWebViewController.h"
#import "FTWViewController.h"
#import "WebCacheViewController.h"
#import "HomTabBarController.h"

@interface HomeInfoController ()

@end

@implementation HomeInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    
    UILabel * newLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 50, 200, 200)];
    newLabel.textColor = [UIColor redColor];
    newLabel.text = @"88898989898989";
    [self.view addSubview:newLabel];
    
    
    UIButton * nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 30, 200, 200)];
    [nextBtn setTitle:@"fff" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor grayColor];
    [nextBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.view addSubview:nextBtn];
    
    [nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UINavigationBar * homeNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 100, MAIN_SCREEN_WITH, 44)];
//    homeNavigationBar.barTintColor = [UIColor greenColor];
//    UINavigationItem * homeNavigationItem = [[UINavigationItem alloc] initWithTitle:@"home页"];
//    [homeNavigationBar pushNavigationItem:homeNavigationItem animated:YES];
//    [self.view addSubview:homeNavigationBar];
    
    
//    UIView * homeTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, 44)];
//    UILabel * titLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, 44)];
//    homeTitleView.tintColor = [UIColor redColor];
//    homeTitleView.backgroundColor = [UIColor greenColor];
//    titLab.text = @"nmmmmmmmmmm";
//    [homeTitleView addSubview:titLab];
//    
//    self.navigationItem.titleView = homeTitleView;
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor greenColor];
    
    
    DrogImageView * drogImageView = [[DrogImageView alloc] initWithFrame:CGRectMake(100, 200, 60, 60)];
    drogImageView.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:drogImageView];
}


-(void)navigationBackButton:(id)sender{
    
}

-(void)nextClick{
    BaseViewController * viewController = [[BaseViewController alloc] init];
    viewController.title = @"info";
    
    UIButton * nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 30, 200, 200)];
    [nextBtn setTitle:@"infoButton" forState:UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor grayColor];
    [nextBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [viewController.view addSubview:nextBtn];
    
    [nextBtn addTarget:self action:@selector(infoNextClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [self.navigationController pushViewController:viewController animated:YES];
    
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        UITabBarController * homeTabBarController = (UITabBarController*)controller.centerController;
        UINavigationController * navigationController = (homeTabBarController.selectedViewController);
        
        
        TestWebViewController * testWebController = [[TestWebViewController alloc] init];
        [navigationController pushViewController:testWebController animated:YES];
        
    }];
    
}

-(void)infoNextClick{
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
//    TestViewController * testViewController = [[TestViewController alloc] init];
//    [self.navigationController pushViewController:testViewController animated:YES];
    
//    SwipePageViewController * swipePageViewController = [[SwipePageViewController alloc] initWithNibName:@"SwipePageViewController" bundle:nil];
    
//    SwipePageViewController * swipePageViewController = [[SwipePageViewController alloc] init];
//    [self.navigationController pushViewController:swipePageViewController animated:YES];
    
//    BaseSearchViewController * baseSearchViewController = [[BaseSearchViewController alloc] init];
//    [self.navigationController pushViewController:baseSearchViewController animated:YES];
//    
//    
//    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"fanhui" style:UIBarButtonItemStyleDone target:self action:@selector(testLeftBtnClick)];
//    baseSearchViewController.navigationItem.leftBarButtonItem = leftBtnItem;
    
//    KCMainViewController * kcMainViewController = [[KCMainViewController alloc] init];
//    [self.navigationController pushViewController:kcMainViewController animated:YES];
    
//    BasketBallViewController * basketBallViewController = [[BasketBallViewController alloc] init];
//    [self.navigationController pushViewController:basketBallViewController animated:YES];
    
    
//    TestWebViewController * testWebController = [[TestWebViewController alloc] init];
//    [self.navigationController pushViewController:testWebController animated:YES];
    
    
//    FTWViewController * ftwViewController = [[FTWViewController alloc] init];
//    [self.navigationController pushViewController:ftwViewController animated:YES];
    
    WebCacheViewController * webCacheViewController = [[WebCacheViewController alloc] init];
    [self.navigationController pushViewController:webCacheViewController animated:YES];
    
}


-(void)testLeftBtnClick{
    DLog(@"拦截了左侧的事件");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = nil;
    
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    
    [super viewWillAppear:animated];
}


@end

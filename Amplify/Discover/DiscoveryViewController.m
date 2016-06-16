//
//  DiscoveryViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/13.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoveryService.h"
#import "HomePageModel.h"
#import "LinkModel.h"
#import "LinkManage.h"
#import "ChangeViewController.h"
#import "ChangeCategoryViewController.h"
#import "ShopCartViewController.h"
#import "TestWebViewController.h"
#import "PerfectInfoViewController.h"
#import "JXAlertViewManage.h"
#import "AddressListView.h"
#import "JXAlertViewManage.h"


//--------
#import "AddNewAddressView.h"
#import "WishAndComModel.h"
#import "RegiserViewController.h"
//---End---

@interface DiscoveryViewController (){
    NSString * discoverUrl;
    
    
    //查找
    NSString * searchUrl;
}

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"商店";
    
    
    UIImage *rightImage = [UIImage imageNamed:@"discoverBag"];
    rightImage =[rightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(shoppingCart:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    UIImage *leftImage = [UIImage imageNamed:@"discoverNav"];
    leftImage =[leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(searchBtnClick:)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    
    [DiscoveryService getDiscoveryPageUrl:^(id responseObj) {
        
        HomePageModel * homePageModel = [HomePageModel mj_objectWithKeyValues:responseObj];
        
        HomepageUrlData * homepageUrlData = homePageModel.responseBody.urlList[0];
        NSString * comUrl = [NSString stringWithFormat:@"%@%@",WebLoadUrl,homepageUrlData.url];
        
        discoverUrl =comUrl;
        
        
        
        [self.baseWebView baseLoadRequest:comUrl];
        
    } withFail:^(NSError *error) {
        
    }];
    
}


-(void)onGoDownRefreshWeb:(void (^)())refreshDownCompleted{
    refreshDownCompleted();
    [self.baseWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.refrshUrl]]];
//    [self.baseWebView reload];
}


//查找
-(void)searchBtnClick:(id)sender{
    ChangeCategoryViewController * changeCategoryViewController = [[ChangeCategoryViewController alloc] init];
    changeCategoryViewController.inputViewData = searchUrl;
    
    
    [self.navigationController pushViewController:changeCategoryViewController animated:YES];
    
//    [JXAlertViewManage showMessageWithAlert:@"fffffffffffffff"];
    
    
}

-(void)shoppingCart:(id)sender{
    
    NSDictionary *shopCartDic = (NSDictionary*)[[BaseWebManager shareWebManager] fixJavascriptDataByFun:@"getBag();" withWebView:self.baseWebView];
    NSString *shopCartUrl = [shopCartDic objectForKey:@"url"];
    
    NSString* comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:shopCartUrl withParameter:[NSDictionary dictionaryWithObject:[UserManager token] forKey:@"token"]];
    ShopCartViewController * shopCartViewController = [[ShopCartViewController alloc] init];
    shopCartViewController.inputViewData = comUrl;
    [self.navigationController pushViewController:shopCartViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //当收到内存警告时,移除当前没有在屏幕上显示的视图.
    
    //判断是否可以安全的移除视图控制器的view.
    
    //判断当前的视图控制器的view是否是屏幕上显示.self.view.window
    
    //判断当前视图控制器的view是否已经成功加载.isViewLoaded
    
//    if( self.view.window == nil && [self isViewLoaded]) {
//        
//        //安全移除控制器的view;
//        
//        self.view = nil;
//        
//    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
    
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
    
    //查找
    NSDictionary * categoryUrlDic = (NSDictionary*)[[BaseWebManager shareWebManager] fixJavascriptDataByFun:@"categoryUrl()" withWebView:webView];
    
    searchUrl= [categoryUrlDic objectForKey:@"url"];
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [super webView:webView didFailLoadWithError:error];
    
}


@end

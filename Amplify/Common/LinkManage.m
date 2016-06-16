//
//  LinkManage.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "LinkManage.h"
#import "AriticleInfoViewController.h"
#import "DiscoverCategoryViewController.h"
#import "DiscoverInfoViewController.h"
#import "GoodListWebViewController.h"
#import "DiscoverNoBarWebController.h"
#import "WishInfoViewController.h"

@implementation LinkManage

+(instancetype)shareInstance{
    static LinkManage * linkManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        linkManage = [[LinkManage alloc] init];
    });
    
    return linkManage;
}



-(void)showWebViewByType:(LinkModel*)linkModel withOrigin:(BaseViewController*)originViewController{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (linkModel.type.integerValue==LinkGood) {//商品详情
            DiscoverInfoViewController * discoverInfoViewController = [[DiscoverInfoViewController alloc] init];
            discoverInfoViewController.inputViewData = linkModel;
            [originViewController.navigationController pushViewController:discoverInfoViewController animated:YES];
        }else if(linkModel.type.integerValue==LinkCategory){//商品分类
            DiscoverCategoryViewController * discoverCategoryViewController = [[DiscoverCategoryViewController alloc] init];
            discoverCategoryViewController.inputViewData = linkModel;
            [originViewController.navigationController pushViewController:discoverCategoryViewController animated:YES];
            
        }else if(linkModel.type.integerValue==LinkBrand){
            DiscoverNoBarWebController * discoverNoBarWebController = [[DiscoverNoBarWebController alloc] init];
            discoverNoBarWebController.inputViewData = linkModel;
            [originViewController.navigationController pushViewController:discoverNoBarWebController animated:YES];

        }else if(linkModel.type.integerValue==LinkGoodList){
            GoodListWebViewController * goodListWebViewController = [[GoodListWebViewController alloc] init];
            goodListWebViewController.inputViewData = linkModel.url;
            [originViewController.navigationController pushViewController:goodListWebViewController animated:YES];
        }else if(linkModel.type.integerValue==LinkLookFor){
            AriticleInfoViewController * ariticleInfoViewController = [[AriticleInfoViewController alloc] init];
            ariticleInfoViewController.inputViewData = linkModel.url;
            [originViewController.navigationController pushViewController:ariticleInfoViewController animated:YES];
        }else if(linkModel.type.integerValue==LinkWish){
            WishInfoViewController * wishInfoViewController = [[WishInfoViewController alloc] init];
            wishInfoViewController.inputViewData = linkModel;
            [originViewController.navigationController pushViewController:wishInfoViewController animated:YES];
        }else if(linkModel.type.integerValue==LinkOther){
            DiscoverCategoryViewController * discoverCategoryViewController = [[DiscoverCategoryViewController alloc] init];
            discoverCategoryViewController.inputViewData = linkModel;
            [originViewController.navigationController pushViewController:discoverCategoryViewController animated:YES];
        }else if(linkModel.type.integerValue==LinkActive){
            DiscoverCategoryViewController * discoverCategoryViewController = [[DiscoverCategoryViewController alloc] init];
            discoverCategoryViewController.inputViewData = linkModel;
            [originViewController.navigationController pushViewController:discoverCategoryViewController animated:YES];
        }
        else{
            DiscoverCategoryViewController * discoverCategoryViewController = [[DiscoverCategoryViewController alloc] init];
            discoverCategoryViewController.inputViewData = linkModel;
            [originViewController.navigationController pushViewController:discoverCategoryViewController animated:YES];
        }
    });
}

@end

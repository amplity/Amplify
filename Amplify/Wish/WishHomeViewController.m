//
//  WishHomeViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/22.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "WishHomeViewController.h"
#import "BaseWebManager.h"
#import "WishService.h"

#import "WishListHomeViewController.h"
#import "WishList2WebViewController.h"
#import "WishListWebViewController.h"

@interface WishHomeViewController ()

@end

@implementation WishHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationItem.title = @"心愿";
    
    UIImage *rightImage = [UIImage imageNamed:@"wishStore"];
    rightImage =[rightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(wishLikeStore:)];
    
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    
    NSMutableArray * wishUrls = [NSMutableArray array];
    
    NSString *comUrl1 = [[BaseWebManager shareWebManager] getCombineUrlByParameter:@"/app/wish/listwish" withParameter:[NSDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%d",WishCurent]] forKeys:@[@"status"]]];
    [wishUrls addObject:comUrl1];
    
    NSString *comUrl2 = [[BaseWebManager shareWebManager] getCombineUrlByParameter:@"/app/wish/listwish" withParameter:[NSDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%d",WishNext]] forKeys:@[@"status"]]];
    [wishUrls addObject:comUrl2];
    
    
    NSString *comUrl3 = [[BaseWebManager shareWebManager] getCombineUrlByParameter:@"/app/wish/listwish" withParameter:[NSDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"%d",WishED]] forKeys:@[@"status"]]];
    [wishUrls addObject:comUrl3];
    
    
    self.inputViewDatas = wishUrls;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
//    if( self.view.window == nil && [self isViewLoaded]) {
//        
//        //安全移除控制器的view;
//        
//        self.view = nil;
//        
//    }
}

//收藏
-(void)wishLikeStore:(id)sender{
    
    
    WishListHomeViewController * wishListHomeViewController = [[WishListHomeViewController alloc] initWithTitles:@[@"我参与的",@"已结束的"] controllersClass:@[[WishListWebViewController class],[WishList2WebViewController class]] inputViewDatas:@[]];
    [self.navigationController pushViewController:wishListHomeViewController animated:YES];
}


@end

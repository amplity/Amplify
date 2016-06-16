//
//  WishListHomeViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/27.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "WishListHomeViewController.h"
#import "BaseWebManager.h"
#import "WishService.h"

@interface WishListHomeViewController ()

@end

@implementation WishListHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.navigationItem.title = @"心愿清单";
    
    
    
    NSMutableArray * wishUrls = [NSMutableArray array];
    
    NSString *comUrl1 = [[BaseWebManager shareWebManager] getCombineUrlByParameter:@"/app/wish/listwish" withParameter:[NSDictionary dictionaryWithObjects:@[[UserManager token],[NSString stringWithFormat:@"%d",WishJoin]] forKeys:@[@"token",@"status"]]];
    [wishUrls addObject:comUrl1];
    
    NSString *comUrl2 = [[BaseWebManager shareWebManager] getCombineUrlByParameter:@"/app/wish/listwish" withParameter:[NSDictionary dictionaryWithObjects:@[[UserManager token],[NSString stringWithFormat:@"%d",WishEnd]] forKeys:@[@"token",@"status"]]];
    [wishUrls addObject:comUrl2];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

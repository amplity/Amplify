//
//  LookForHomeViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/21.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "LookForHomeViewController.h"
#import "ArticleCollectViewController.h"
#import "HomePageModel.h"
#import "BaseWebManager.h"
#import "LookForService.h"
#import "AriticleInfoViewController.h"
#import "ArticleCollectViewController2.h"
#import "ShareManage.h"
#import "LookForShareFrameView.h"
#import "ShareModel.h"
#import "LoginViewController.h"
#import "HomeService.h"
#import "MoviePlayerViewController.h"

@interface LookForHomeViewController (){
    ShareModel * shareModel;
}

@end

@implementation LookForHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"物色";
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




@end

//
//  LookForViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "LookForViewController.h"

@interface LookForViewController ()

@end

@implementation LookForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"物色";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HexRGB(0x000000)}];
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"discover_daf"] style:UIBarButtonItemStylePlain target:self action:@selector(likeStore:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


//收藏
-(void)likeStore:(id)sender{
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end

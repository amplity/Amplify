//
//  ArticleCollectViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "ArticleCollectViewController.h"

@interface ArticleCollectViewController ()

@end

@implementation ArticleCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"discover_daf"] style:UIBarButtonItemStylePlain target:self action:@selector(editClick:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//编辑
-(void)editClick:(id)sender{
    
    ArticleCollectViewController * articleCollectViewController = [[ArticleCollectViewController alloc] init];
    articleCollectViewController.view.backgroundColor = [UIColor blackColor];
    [self.navigationController pushViewController:articleCollectViewController animated:YES];
}

@end

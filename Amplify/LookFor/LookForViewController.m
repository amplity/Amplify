//
//  LookForViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "LookForViewController.h"
#import "ArticleCollectViewController.h"

@interface LookForViewController ()

@end

@implementation LookForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"物色";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HexRGB(0x999999)}];
    
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"discover_daf"] style:UIBarButtonItemStylePlain target:self action:@selector(likeStore:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    self.navigationController.navigationBar.barTintColor = HexRGBAlpha(0x000000,.6);
    
    
    //设置字体
    
    for (UITabBarItem * tabBarItem in self.tabBar.items) {
        
        NSDictionary * fontDic=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Baskerville" size:20.0],NSFontAttributeName, nil];
        [tabBarItem setTitleTextAttributes:fontDic forState:UIControlStateNormal];
        
        
    }
    
    self.tabBar.selectedItem = self.tabBar.items[0];
    
    [self viewShowForIndex:0];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


//收藏
-(void)likeStore:(id)sender{
    
    ArticleCollectViewController * articleCollectViewController = [[ArticleCollectViewController alloc] init];
    articleCollectViewController.view.backgroundColor = [UIColor blackColor];
    [self.navigationController pushViewController:articleCollectViewController animated:YES];
}

-(void)viewShowForIndex:(NSInteger)index{
    self.oneView.hidden = YES;
    self.twoView.hidden = YES;
    self.threeView.hidden = YES;
    self.fourView.hidden = YES;
    
    switch (index) {
        case 0:
            self.oneView.hidden = NO;
            break;
        case 1:
            self.twoView.hidden = NO;
            break;
        case 2:
            self.threeView.hidden = NO;
            break;
        case 3:
            self.fourView.hidden = NO;
            break;
            
        default:
            break;
    }
}


#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [self viewShowForIndex:item.tag];
    
}




@end

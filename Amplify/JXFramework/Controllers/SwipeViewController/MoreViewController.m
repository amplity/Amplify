//
//  MoreViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController (){
    UILabel * lab;
}

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}


- (void) loadView{
    [super loadView];
    self.myWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, MAIN_SCREEN_WITH, 50)];
    
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    
}

- (void) viewWillAppear:(BOOL)paramAnimated{
    [super viewWillAppear:paramAnimated];
//    [self.myWebView loadHTMLString:_dataObject baseURL:nil];
//    [self.view addSubview:self.myWebView];
    
    lab.text = _dataObject;
    
}

- (void) viewWillDisappear:(BOOL)paramAnimated{
    
}

@end

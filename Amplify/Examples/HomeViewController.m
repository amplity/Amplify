//
//  HomeViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/1/26.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeInfoController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.title = @"ffff";
    self.navigationItem.title = @"发现频道";

    NSLog(@"%@",self.navigationController);
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(selectLeftAction:)];
//    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(selectRightAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(selectBackAction:)];
    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"sfssf" style:UIBarButtonItemStylePlain target:self action:@selector(selectBackAction:)];
    
    self.navigationItem.backBarButtonItem = backButton;
    
    
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
//    self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, 44)];
//    self.navigationItem.titleView.backgroundColor = [UIColor redColor];
    
    
    
    DLog(@"titleView===%@",self.navigationItem.titleView);
    
}

-(void)selectLeftAction:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏左按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}

-(void)selectRightAction:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了导航栏右按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}

-(void)selectBackAction:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你点击了返回栏右按钮" delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextClick:(id)sender {
    
    HomeInfoController * homeInfoController = [[HomeInfoController alloc] init];
    
    [self.navigationController pushViewController:homeInfoController animated:YES];
}
@end

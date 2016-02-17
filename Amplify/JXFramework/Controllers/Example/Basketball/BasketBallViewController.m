//
//  BasketBallViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/17.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BasketBallViewController.h"
#import "DrogImageView.h"

@interface BasketBallViewController ()

@end

@implementation BasketBallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.backImageView.image = [UIImage imageNamed:@"basketballBg"];
    
    
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 64)];
    titleView.backgroundColor = [UIColor greenColor];
    
    UIButton * oneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [oneBtn setTitle:@"甲方" forState:UIControlStateNormal];
    [titleView addSubview:oneBtn];
    [oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * secondBtn = [[UIButton alloc] initWithFrame:CGRectMake(70, 0, 50, 40)];
    [secondBtn setTitle:@"乙方" forState:UIControlStateNormal];
    [titleView addSubview:secondBtn];
    [secondBtn addTarget:self action:@selector(secondBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleView;
}

-(void)oneBtnClick{
    DrogImageView * oneDrogImageView = [[DrogImageView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    oneDrogImageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview: oneDrogImageView];
}

-(void)secondBtnClick{
    DrogImageView * secondDrogImageView = [[DrogImageView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    secondDrogImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview: secondDrogImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

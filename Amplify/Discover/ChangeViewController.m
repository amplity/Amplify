//
//  ChangeViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/14.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "ChangeViewController.h"

@interface ChangeViewController ()

@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 240, 50)];
    [headView addSubview:searchBar];
    self.navigationItem.titleView = headView;
    
    
    
    [self initHotBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if( self.view.window == nil && [self isViewLoaded]) {
        
        //安全移除控制器的view;
        
        self.view = nil;
        
    }
}

//热词
-(void)initHotBtn{
    self.recommendScrollView.bounces = NO;
    for (int i= 0; i<8; i++) {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(i*80, 0, 80, 60)];
        [button setTitle:[NSString stringWithFormat:@"fffff%d",i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor grayColor];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.recommendScrollView addSubview:button];
    }
    
    self.recommendScrollView.contentSize = CGSizeMake(8*80, 60);
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //subclass
    UITableViewCell * tableCell = [[UITableViewCell alloc] init];
    
    return tableCell;
}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 40;
}


@end

//
//  BaseMultipleSectionTableViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/2.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseMultipleSectionTableViewController.h"

@interface BaseMultipleSectionTableViewController ()

@end

@implementation BaseMultipleSectionTableViewController


#pragma -mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 14;
            break;
            
        default:
            return 4;
            break;
    }
}

@end

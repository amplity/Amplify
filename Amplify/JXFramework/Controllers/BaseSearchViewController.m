//
//  BaseSearchViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseSearchViewController.h"

@interface BaseSearchViewController ()

@end

@implementation BaseSearchViewController


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mySearchController.searchBar becomeFirstResponder];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initial];
}

- (void)initial{
    self.dataSourceArray = [NSMutableArray array];
    self.filterArray = [NSMutableArray array];
    for (int i = 0; i < 26; i++) {
        for (int j = 0; j < 4; j++) {
            NSString *str = [NSString stringWithFormat:@"%c%d", 'A'+i, j];
            [self.dataSourceArray addObject:str];
        }
    }
    
    self.visableArray = self.dataSourceArray;
    
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    
    self.mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _mySearchController.searchResultsUpdater = self;
    _mySearchController.dimsBackgroundDuringPresentation = NO;
    [_mySearchController.searchBar sizeToFit];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.mySearchController.searchBar becomeFirstResponder];
//    });
    
    self.myTableView.tableHeaderView = self.mySearchController.searchBar;
    self.mySearchController.searchBar.delegate = self;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!_visableArray || _visableArray.count == 0) {
        _visableArray = _dataSourceArray;
    }
    return _visableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    
    cell.textLabel.text = [_visableArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *filterString = searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", filterString];
    
    self.visableArray = [NSMutableArray arrayWithArray:[self.dataSourceArray filteredArrayUsingPredicate:predicate]];
    
    [self.myTableView reloadData];
}

#pragma mark - UISearchBarDelegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    DLog(@"取消点击");
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

@end

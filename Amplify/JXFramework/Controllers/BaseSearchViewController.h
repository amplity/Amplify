//
//  BaseSearchViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"


/**
 *  此类暂时停用
 */

@interface BaseSearchViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *titleHeadView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollHotView;


@property (nonatomic, strong) NSMutableArray *visableArray;
@property (nonatomic, strong) NSMutableArray *filterArray;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UISearchController *mySearchController;

@end

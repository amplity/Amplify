//
//  BaseSearchViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseSearchViewController.h"
#import "DiscoverSearchModel.h"
#import "DiscoveryService.h"
#import "GoodListWebViewController.h"


@interface BaseSearchViewController ()

@end

@implementation BaseSearchViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.mySearchController.searchBar becomeFirstResponder];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initial];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.view.window == nil && [self isViewLoaded]) {
        //安全移除控制器的view;
        self.view = nil;
    }
}

- (void)initial {
    self.dataSourceArray = [NSMutableArray array];
//    self.filterArray = [NSMutableArray array];
//    for (int i = 0; i < 26; i++) {
//        for (int j = 0; j < 4; j++) {
//            NSString *str = [NSString stringWithFormat:@"%c%d", 'A' + i, j];
//            [self.dataSourceArray addObject:str];
//        }
//    }

    self.visableArray = self.dataSourceArray;

    _myTableView.delegate = self;
    _myTableView.dataSource = self;

    self.mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _mySearchController.searchResultsUpdater = self;
    _mySearchController.dimsBackgroundDuringPresentation = NO;

    self.mySearchController.searchBar.frame = CGRectMake(0, 7, self.mySearchController.searchBar.bounds.size.width, self.mySearchController.searchBar.bounds.size.height);
    [self.titleHeadView addSubview:self.mySearchController.searchBar];

    self.mySearchController.searchBar.barStyle = UIBarStyleDefault;
    self.mySearchController.searchBar.barTintColor = [UIColor blackColor];
    self.mySearchController.searchBar.delegate = self;

//    [self showHotBtnView:[NSArray arrayWithObjects:@"呜呜呜呜", @"quu我", @"你妹", @"ssssss", @"ff", @"fsfsfsfsfsfsfsf", @"呜呜方法呜呜", @"呜呜呜分呜", @"呜是是是呜呜呜", @"分呜呜呜呜", nil]];
}

//热词
- (void)showHotBtnView:(NSArray *)hotArray {
    //contentsize  with
    CGFloat contentSizeWidth = 0.0;
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 20;//用来控制button距离父视图的高
    int i = 0;
    for (NSString *hotStr in hotArray) {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor whiteColor];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:6.0];
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //根据计算文字的大小

        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
        CGFloat length = [hotStr boundingRectWithSize:CGSizeMake(MAIN_SCREEN_WITH, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:hotStr forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 20, 30);

        w = button.frame.size.width + button.frame.origin.x;
        [self.scrollHotView addSubview:button];
        contentSizeWidth = button.frame.origin.x + button.frame.size.width;
        i++;
    }

    self.scrollHotView.contentSize = CGSizeMake(contentSizeWidth, 60);
    self.scrollHotView.bounces = NO;
}

//点击事件
- (void)handleClick:(UIButton *)btn {
    [TipManager showTipsWithInforStr:[NSString stringWithFormat:@"%ld", btn.tag] withAfter:1.0];
}

//跳转到查询
- (void)goToResultGooList {
    __weak typeof(self) weakSelf = self;
    [DiscoveryService queryDiscoverGoodList:^(id responseObj) {
        NSString *url = [[responseObj objectForKey:@"responseBody"] objectForKey:@"url"];
        GoodListWebViewController *goodListWebViewController = [[GoodListWebViewController alloc] init];
        goodListWebViewController.inputViewData = url;
        [weakSelf.navigationController pushViewController:goodListWebViewController animated:YES];
    }                              withFail:^(NSError *error) {

    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_visableArray || _visableArray.count == 0) {
        _visableArray = _dataSourceArray;
    }
    return _visableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }

    cell.textLabel.text = [_visableArray objectAtIndex:indexPath.row];

    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *filterString = searchController.searchBar.text;

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [c] %@", filterString];

    self.visableArray = [NSMutableArray arrayWithArray:[self.dataSourceArray filteredArrayUsingPredicate:predicate]];

    [self.myTableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * wordStr = [self.dataSourceArray objectAtIndex:indexPath.row];

    wordStr = [wordStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    GoodListWebViewController * goodListWebViewController = [[GoodListWebViewController alloc] init];
    goodListWebViewController.inputViewData = [NSString stringWithFormat:@"/search/list?content=%@", wordStr];
    [self.navigationController pushViewController:goodListWebViewController animated:YES];

}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    DLog(@"取消点击");

    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {


    return YES;
}

//搜索改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [DiscoveryService queryWords:searchText withSucess:^(id responseObj) {
        NSNumber *status = [responseObj objectForKey:@"status"];
        if ([status intValue] == 1) {
            self.dataSourceArray = [responseObj objectForKey:@"list"];
            [_myTableView reloadData];
        }
    }                   withFail:^(NSError *error) {

    }];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mySearchController.searchBar setHidden:YES];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}
@end

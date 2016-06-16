//
//  BaseTableController.m
//  Amplify
//
//  Created by ZhangJixu on 16/1/27.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseTableController.h"
#import "BaseTableCell.h"

@interface BaseTableController ()

@end

@implementation BaseTableController

#pragma mark - Propertys
-(NSMutableArray*)baseDataSource{
    if (nil == _baseDataSource) {
        _baseDataSource = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _baseDataSource;
}

-(NSMutableArray*)cellStyles{
    if (nil == _cellStyles) {
        _cellStyles = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _cellStyles;
}

-(void)initData{
    
}

#pragma mark - life cycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initData];
    
    //刷新down
    MJRefreshNormalHeader * normalHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(goDownRefresh)];
    self.tableview.mj_header = normalHeader;
    
    //刷新up
    MJRefreshAutoNormalFooter * autoFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(goUpRefresh)];
    self.tableview.mj_footer = autoFooter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    self.baseDataSource = nil;
    self.tableview = nil;
    self.tableview.dataSource = nil;
    self.tableview.delegate = nil;
}

#pragma -mark public
-(void)onGoUpRefresh:(UpRefreshBlock)block{
    //subClass
}

-(void)onGoDownRefresh:(DownRefreshBlock)block{
    //subClass
}

#pragma -mark mjrefresh private
-(void)goDownRefresh{
    
    [self onGoDownRefresh:^{
        [self.tableview.mj_header endRefreshing];
        [self.tableview.mj_footer resetNoMoreData];
        DLog(@"下拉刷新成功");
    }];
    
    
}

-(void)goUpRefresh{
    
    
    [self onGoUpRefresh:^(BOOL hasNewData) {
        if (hasNewData) {
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
            DLog(@"上拉刷新成功");
        }else{
            [self.tableview.mj_footer endRefreshing];
            DLog(@"上拉刷新成功");
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.baseDataSource.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //subclass
    return nil;
}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableCell * baseTableCell = [_cellStyles objectAtIndex:indexPath.row];
    [baseTableCell setCellData:nil];
    
    return baseTableCell.height;
}


#pragma mark - BaseTableCellDelegate
-(void)baseTableCellClick:(NSString *)clickName withObjec:(id)obj{
    //subclass
}

@end

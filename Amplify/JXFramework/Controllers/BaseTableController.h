//
//  BaseTableController.h
//  Amplify
//
//  Created by ZhangJixu on 16/1/27.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

/**
 *  大量数据的数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

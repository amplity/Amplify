//
//  BaseTableController.h
//  Amplify
//
//  Created by ZhangJixu on 16/1/27.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^DownRefreshBlock)();
typedef void(^UpRefreshBlock)(BOOL hasNewData);

@interface BaseTableController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

/**
 *  大量数据的数据源
 */
@property (nonatomic, strong) NSMutableArray *baseDataSource;

/**
 *  下拉刷新
 *
 *  @param block 下拉完成block
 */
-(void)onGoDownRefresh:(DownRefreshBlock)block;


/**
 *  上拉刷新
 *
 *  @param block 上拉完成block
 */
-(void)onGoUpRefresh:(UpRefreshBlock)block;

@end

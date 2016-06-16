//
//  TestViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/2.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "TestViewController.h"
#import "BaseService.h"
#import "HomeModel.h"
#import "BaseTableCell.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    
}

-(void)initData{
    NSArray * arr = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    [self.baseDataSource addObjectsFromArray:arr];
    
    
    BaseTableCell* tableCell = [[BaseTableCell alloc] init];
    tableCell.height = 50;
    
    
    for (int i=0; i<self.baseDataSource.count; i++) {
        [self.cellStyles addObject:tableCell];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testUrlForHttp{
    [BaseService postDataWithUrl:@"rest?method=makeUpTheme" withParameters:[self combinParameters] withSuccess:^(id responseObj) {
        
        NSFileManager * fileManager = [NSFileManager defaultManager];
        
        NSString * cacheStr = NSHomeDirectory();
        
        NSString * temStr = NSTemporaryDirectory();
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString * documentDirectory = [paths lastObject];
        NSString * fileName = [documentDirectory stringByAppendingPathComponent:@"test.txt"];
        
        
        [[responseObj objectForKey:@"responseBody"] writeToFile:fileName atomically:YES];
        
        
        HomeModel * homeModel = [HomeModel mj_objectWithKeyValues:responseObj];
        MJExtensionLog(@"%ld", (long)homeModel.responseBody.totalPages);
        MJExtensionLog(@"%@",homeModel.responseBody.makeUpthemeLists);
        for (MakeUptheme *status in homeModel.responseBody.makeUpthemeLists) {
            NSInteger text = status.likesCount;
            NSString *name = status.themeTitle;
            NSString *icon = status.themeUrl;
            MJExtensionLog(@"text=%ld, name=%@, icon=%@", (long)text, name, icon);
        }
        
        DLog(@"");
    } withFail:^(NSError *error){
        DLog(@"");
    }];
}

- (NSDictionary *)combinParameters
{
    return  @{
              @"requestHead": @{@"platform":@"iOS", @"version":@"1.1",@"token":@"anonymous"},
              @"requestBody": @{@"perpageNums":@"3",@"requestPage":@"0"}
              };
}


#pragma -mark UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableCell * cell = [[BaseTableCell alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, 44)];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, 44)];
    NSString *arrStr =[self.baseDataSource objectAtIndex:indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    if (indexPath.row ==1) {
        label.text = [NSString stringWithFormat:@"点击我！！！！！！！%@",arrStr];
    }else{
        label.text = [NSString stringWithFormat:@"显示数量=====%@",arrStr];
    }
    
    [cell addSubview:label];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==1) {
        [self testUrlForHttp];
    }
}


@end

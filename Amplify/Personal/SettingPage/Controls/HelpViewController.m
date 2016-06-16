//
//  HelpViewController.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/3.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "HelpViewController.h"
#import "HelpTableViewCell.h"
#import "HelpObject.h"
#import "BaseTableCell.h"
#import "HelpWebViewController.h"

@interface HelpViewController (){
    NSArray* titleList;//标题
    NSArray* buyGoodGuideList;//购物指南
    NSArray* buyGoodGuideHttpList;
    NSArray* sendInfoList;//配送信息
    NSArray* sendInfoListHttpList;
    NSArray* onLinePayList;//在线支付
    NSArray* onLinePayListHttpList;
    NSArray* changeInfoList;//退换货信息
    NSArray* changeInfoListHttpList;
    NSArray* linkUseList;//联系我们
    NSArray* linkUseListHttpList;
    
    
}

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"帮助中心";
    titleList = [NSArray arrayWithObjects:@"购物指南",@"配送信息",@"在线支付",@"退换货信息",@"联系我们", nil];
    
    buyGoodGuideList = [NSArray arrayWithObjects:@"HARMAY积分说明",@"怎样注册话梅网账号？",@"怎样邀请好友加入？",@"怎样绑定淘宝、京东账号？",nil];
    buyGoodGuideHttpList = [NSArray arrayWithObjects:@"/help/about",@"/help/how-to-regist",@"/help/how-to-invite",@"/help/how-to-bind", nil];
    
    sendInfoList = [NSArray arrayWithObjects:@"配送范围",@"免费配送",@"货到付款", nil];
    sendInfoListHttpList = [NSArray arrayWithObjects:@"/help/diliver#price",@"/help/diliver#free",@"/help/diliver#offline", nil];
    
    onLinePayList = [NSArray arrayWithObjects:@"在线支付",@"在线支付安全吗？",@"微信中使用支付宝支付的问题", nil];
    onLinePayListHttpList = [NSArray arrayWithObjects:@"/help/pay#alipay",@"/help/pay#safe",@"/help/pay#wechat", nil];
    
    changeInfoList = [NSArray arrayWithObjects:@"退换货流程",@"退换货条件",@"不予退换货情形",@"运费承担",@"退款说明", nil];
    changeInfoListHttpList = [NSArray arrayWithObjects:@"/help/return#flow",@"/help/return#condition",@"/help/return#noreturns",@"/help/return#fee",@"/help/return#mymoney", nil];
    
    linkUseList = [NSArray arrayWithObjects:@"客户服务",@"其他咨询",@"加入我们",@"问题反馈", nil];
    linkUseListHttpList = [NSArray arrayWithObjects:@"/help/contact-us#service",@"/help/contact-us#contact",@"/help/join-us",@"/help/feedback", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if( self.view.window == nil && [self isViewLoaded]) {
        
        //安全移除控制器的view;
        
        self.view = nil;
        
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - UITableViewDataSource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger sectionCellNums;
    switch (section) {
        case 0:
            sectionCellNums = buyGoodGuideList.count;
            break;
        case 1:
            sectionCellNums = sendInfoList.count;
            break;
        case 2:
            sectionCellNums = onLinePayList.count;
            break;
        case 3:
            sectionCellNums = changeInfoList.count;
            break;
        case 4:
            sectionCellNums = linkUseList.count;
            break;
            
        default:
            break;
    }
    
    return sectionCellNums;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BaseTableCell * baseTableCell = nil;
    
    baseTableCell = [tableView dequeueReusableCellWithIdentifier:@"HelpTableViewCellIndenifier"];
    if(!baseTableCell){
        baseTableCell = [[HelpTableViewCell alloc] init];
        baseTableCell.baseTableCellDelegate = self;
        
    }
    HelpObject* helpObject;
    
    
    switch (indexPath.section) {
        case 0:
            
            helpObject = [[HelpObject alloc] init];
            helpObject.httpUrl = [buyGoodGuideHttpList objectAtIndex:indexPath.row];
            helpObject.titileNameStr = [buyGoodGuideList objectAtIndex:indexPath.row];
            
            [baseTableCell setCellData:helpObject];
            
            break;
        case 1:
            helpObject = [[HelpObject alloc] init];
            helpObject.httpUrl = [sendInfoListHttpList objectAtIndex:indexPath.row];
            helpObject.titileNameStr = [sendInfoList objectAtIndex:indexPath.row];
            
            [baseTableCell setCellData:helpObject];
            break;
        case 2:
            helpObject = [[HelpObject alloc] init];
            helpObject.httpUrl = [onLinePayListHttpList objectAtIndex:indexPath.row];
            helpObject.titileNameStr = [onLinePayList objectAtIndex:indexPath.row];
            
            [baseTableCell setCellData:helpObject];
            break;
        case 3:
            helpObject = [[HelpObject alloc] init];
            helpObject.httpUrl = [changeInfoListHttpList objectAtIndex:indexPath.row];
            helpObject.titileNameStr = [changeInfoList objectAtIndex:indexPath.row];
            
            [baseTableCell setCellData:helpObject];
            break;
        case 4:
            helpObject = [[HelpObject alloc] init];
            helpObject.httpUrl = [linkUseListHttpList objectAtIndex:indexPath.row];
            helpObject.titileNameStr = [linkUseList objectAtIndex:indexPath.row];
            
            [baseTableCell setCellData:helpObject];
            break;

            
        default:
            break;
    }
    
    return baseTableCell;
    
}

#pragma mark

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, 40)];
    headerBgView.backgroundColor= HexRGB(0xEFEFF4);
    UILabel * headerTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 240, 40)];
    headerTitleLab.text = [titleList objectAtIndex:section];
    headerTitleLab.font = [UIFont fontWithName:@"Helvetica" size:15];
//    [UIFont boldSystemFontOfSize:18.0]
    headerTitleLab.textColor = HexRGB(0x555555);
    [headerBgView addSubview:headerTitleLab];
    
    return headerBgView;
}

#pragma mark - 
-(void)baseTableCellClick:(NSString *)clickName withObjec:(id)obj{
    if([clickName isEqualToString:@"HelpTableViewCell"]){
        HelpWebViewController * helpWebViewController =[[HelpWebViewController alloc] init];
        helpWebViewController.inputViewData = obj;
        [self.navigationController pushViewController:helpWebViewController animated:YES];
    }
}

@end

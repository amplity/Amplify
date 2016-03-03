//
//  ArticleCollectViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "ArticleCollectViewController.h"
#import "KCContact.h"
#import "KCContactGroup.h"
#import "BaseTableCell.h"
#import "SCTableViewController.h"

#import "ArticleCollectCell.h"

static NSString * CellSelectAll = @"CellSelectAll";//全选中
static NSString * CellSelectAllCancle = @"CellSelectAllCancle";//全取消
static NSString * CellSelectAlong = @"CellSelectAlong";//单独点击

@interface ArticleCollectViewController (){
    NSMutableArray *_contacts;//联系人模型
    
    //编辑
    UIBarButtonItem * rightBarButtonItem;
    
    //编辑状态
    BOOL tabEditing;
    
    
    //选中的header部分
    NSMutableDictionary * selectedHeaderDic;
    //选中的tableViewCell
    NSMutableDictionary * selectedTableViewCellDic;
}

@end

@implementation ArticleCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tabEditing = NO;
    [self editRightBar];
    self.deleteView.hidden = YES;
    
    
    selectedHeaderDic = [[NSMutableDictionary alloc] init];
    selectedTableViewCellDic = [[NSMutableDictionary alloc] init];
}

/**
 *  设置右上角的编辑
 */
-(void)editRightBar{
    if(tabEditing){
        rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(editClick:)];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }else{
        rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"discover_daf"] style:UIBarButtonItemStylePlain target:self action:@selector(editClick:)];
        
    }
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//编辑
-(void)editClick:(id)sender{

    tabEditing = !tabEditing;
    self.deleteView.hidden = !tabEditing;
    [self.tableview reloadData];
    
    [self editRightBar];
}

#pragma mark 加载数据
-(void)initData{
    _contacts=[[NSMutableArray alloc]init];
    
    KCContact *contact1=[KCContact initWithFirstName:@"Cui" andLastName:@"Kenshin" andPhoneNumber:@"18500131234"];
    KCContact *contact2=[KCContact initWithFirstName:@"Cui" andLastName:@"Tom" andPhoneNumber:@"18500131237"];
    KCContactGroup *group1=[KCContactGroup initWithName:@"C" andDetail:@"With names beginning with C" andContacts:[NSMutableArray arrayWithObjects:contact1,contact2, nil]];
    [_contacts addObject:group1];
    
    
    
    KCContact *contact3=[KCContact initWithFirstName:@"Lee" andLastName:@"Terry" andPhoneNumber:@"18500131238"];
    KCContact *contact4=[KCContact initWithFirstName:@"Lee" andLastName:@"Jack" andPhoneNumber:@"18500131239"];
    KCContact *contact5=[KCContact initWithFirstName:@"Lee" andLastName:@"Rose" andPhoneNumber:@"18500131240"];
    KCContactGroup *group2=[KCContactGroup initWithName:@"L" andDetail:@"With names beginning with L" andContacts:[NSMutableArray arrayWithObjects:contact3,contact4,contact5, nil]];
    [_contacts addObject:group2];
    
    
    
    KCContact *contact6=[KCContact initWithFirstName:@"Sun" andLastName:@"Kaoru" andPhoneNumber:@"18500131235"];
    KCContact *contact7=[KCContact initWithFirstName:@"Sun" andLastName:@"Rosa" andPhoneNumber:@"18500131236"];
    
    KCContactGroup *group3=[KCContactGroup initWithName:@"S" andDetail:@"With names beginning with S" andContacts:[NSMutableArray arrayWithObjects:contact6,contact7, nil]];
    [_contacts addObject:group3];
    
    
    KCContact *contact8=[KCContact initWithFirstName:@"Wang" andLastName:@"Stephone" andPhoneNumber:@"18500131241"];
    KCContact *contact9=[KCContact initWithFirstName:@"Wang" andLastName:@"Lucy" andPhoneNumber:@"18500131242"];
    KCContact *contact10=[KCContact initWithFirstName:@"Wang" andLastName:@"Lily" andPhoneNumber:@"18500131243"];
    KCContact *contact11=[KCContact initWithFirstName:@"Wang" andLastName:@"Emily" andPhoneNumber:@"18500131244"];
    KCContact *contact12=[KCContact initWithFirstName:@"Wang" andLastName:@"Andy" andPhoneNumber:@"18500131245"];
    KCContactGroup *group4=[KCContactGroup initWithName:@"W" andDetail:@"With names beginning with W" andContacts:[NSMutableArray arrayWithObjects:contact8,contact9,contact10,contact11,contact12, nil]];
    [_contacts addObject:group4];
    
    
    KCContact *contact13=[KCContact initWithFirstName:@"Zhang" andLastName:@"Joy" andPhoneNumber:@"18500131246"];
    KCContact *contact14=[KCContact initWithFirstName:@"Zhang" andLastName:@"Vivan" andPhoneNumber:@"18500131247"];
    KCContact *contact15=[KCContact initWithFirstName:@"Zhang" andLastName:@"Joyse" andPhoneNumber:@"18500131248"];
    KCContactGroup *group5=[KCContactGroup initWithName:@"Z" andDetail:@"With names beginning with Z" andContacts:[NSMutableArray arrayWithObjects:contact13,contact14,contact15, nil]];
    [_contacts addObject:group5];
    
    self.baseDataSource = _contacts;
    
    for (KCContactGroup* groupKcc in _contacts) {
        for (KCContact * contactKc in groupKcc.contacts) {
            BaseTableCell * cell = [[ArticleCollectCell alloc] init];
            [self.cellStyles addObject:cell];
        }
    }
    
}

#pragma mark - 数据源方法,UITableViewDataSource

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"计算每组(组%li)行数",(long)section);
    KCContactGroup *group1=_contacts[section];
    return group1.contacts.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(组：%li,行%li)",(long)indexPath.section,(long)indexPath.row);
    KCContactGroup *group=_contacts[indexPath.section];
    KCContact *contact=group.contacts[indexPath.row];

    static NSString* identifier = @"ArticleCollectIdentifier";
    ArticleCollectCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[ArticleCollectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell setCellData:contact];
    cell.selectImageBtn.hidden = !tabEditing;//编辑状态
   
    
    if (tabEditing) {//编辑状态下
        
        
        if ([[selectedTableViewCellDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]] isEqualToString:CellSelectAll]) {
            cell.selectImageBtn.selected = YES;
            [cell.selectImageBtn setTitle:@"被选中" forState:UIControlStateSelected];
        }else if([[selectedTableViewCellDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]] isEqualToString:CellSelectAllCancle]){
            cell.selectImageBtn.selected = NO;
            [cell.selectImageBtn setTitle:@"未选中" forState:UIControlStateNormal];
        }
        
        
        //单个点击状态
        if([[selectedTableViewCellDic objectForKey:indexPath] isEqualToString:CellSelectAlong]){
            [cell.selectImageBtn setTitle:@"被选中" forState:UIControlStateSelected];
        }else{
            [cell.selectImageBtn setTitle:@"未选中" forState:UIControlStateSelected];
        }
    }else{
        
    }
    
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSLog(@"生成组（组%li）名称",(long)section);
    KCContactGroup *group=_contacts[section];
    return group.name;
}

#pragma mark 返回每组尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSLog(@"生成尾部（组%li）详情",(long)section);
    KCContactGroup *group=_contacts[section];
    return group.detail;
}


//添加一项
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tabEditing) {
        [selectedTableViewCellDic setObject:CellSelectAlong forKey:indexPath];
       
        [self.tableview reloadData];
    }
}

//取消一项
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tabEditing) {
        [selectedTableViewCellDic removeObjectForKey:indexPath];
        
        [self.tableview reloadData];
    }
}


#pragma mark - UITableViewDelegate

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}



//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    KCContactGroup *group =_contacts[indexPath.section];
//    KCContact *contact=group.contacts[indexPath.row];
//    if (editingStyle==UITableViewCellEditingStyleDelete) {
//        [group.contacts removeObject:contact];
//        //考虑到性能这里不建议使用reloadData
//        //[tableView reloadData];
//        //使用下面的方法既可以局部刷新又有动画效果
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//        
//        //如果当前组中没有数据则移除组刷新整个表格
//        if (group.contacts.count==0) {
//            [_contacts removeObject:group];
//            [tableView reloadData];
//        }
//    }
//}

//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return @"下载";
//}


- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //设置删除按钮
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        KCContactGroup *group =_contacts[indexPath.section];
        KCContact *contact=group.contacts[indexPath.row];
        [group.contacts removeObject:contact];
        //考虑到性能这里不建议使用reloadData
        //[tableView reloadData];
        //使用下面的方法既可以局部刷新又有动画效果
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        
        //如果当前组中没有数据则移除组刷新整个表格
        if (group.contacts.count==0) {
            [_contacts removeObject:group];
            [tableView reloadData];
        }
    }];
    
    //设置收藏按钮
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏"handler:^(UITableViewRowAction*action,NSIndexPath *indexPath) {
        
        
        collectRowAction.backgroundColor = [UIColor greenColor];
        
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"收藏" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertView show];
        
        
    }];
    
    collectRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    collectRowAction.backgroundColor = [UIColor grayColor];
    
    return  @[deleteRowAction,collectRowAction];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, 40)];
    
    UIButton * selectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(MAIN_SCREEN_WITH-200,0 , 200, 40)];
    
    [selectedBtn setTitleColor:HexRGB(0x000000) forState:UIControlStateNormal];
    
    [selectedBtn addTarget:self action:@selector(headerBtnClick:withSection:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [headerView addSubview:selectedBtn];
    
    UILabel * titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, 40)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    KCContactGroup *group=_contacts[section];
    [titleLab setText:group.name];
    [headerView addSubview:titleLab];
    
    if (tabEditing) {//编辑状态下设置header
        
        if ([[selectedTableViewCellDic objectForKey:[NSString stringWithFormat:@"%ld",(long)section]] isEqualToString:CellSelectAll]) {//当前分组的cell全部选中
            [selectedBtn setTitle:@"全部取消" forState:UIControlStateNormal];
        }else if([[selectedTableViewCellDic objectForKey:[NSString stringWithFormat:@"%ld",(long)section]] isEqualToString:CellSelectAllCancle]){
            [selectedBtn setTitle:@"全部选中" forState:UIControlStateNormal];
        }
        
        selectedBtn.hidden = NO;
    }else{
        selectedBtn.hidden = YES;
    }
    
    return headerView;
}


/**
 *  当前分组下cell 是否全部选中
 *
 *  @param section 分组索引
 *
 *  @return
 */
-(BOOL)cellSelectedOnSection:(NSInteger)section{
    KCContactGroup *group=_contacts[section];
    
    int currentSectionCellCout = 0;
    
    for (NSString* cellSection  in selectedTableViewCellDic) {
        if (cellSection.integerValue == section) {//在同一的分组下
            currentSectionCellCout++;
        }
    }
    
    
    if (group.contacts.count == currentSectionCellCout) {
        return YES;
    }
    
    return NO;
}

#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //KCStatusTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    ArticleCollectCell *cell= self.cellStyles[indexPath.row];
    KCContactGroup *group=_contacts[indexPath.section];
    KCContact *contact=group.contacts[indexPath.row];
    [cell setCellData:contact];
    
    return cell.height;
}

/**
 *  点击分组头部
 *
 *  @param sender <#sender description#>
 */
-(void)headerBtnClick:(id)sender withSection:(NSInteger)section{
    
    UIButton * btn = sender;
    
    NSString * sectionStr = [NSString stringWithFormat:@"%ld",(long)section];
    
    if ([btn.titleLabel.text isEqualToString:@"全部取消"]) {
        [selectedTableViewCellDic setObject:CellSelectAll forKey:sectionStr];
    }else{
        [selectedTableViewCellDic setObject:CellSelectAllCancle forKey:sectionStr];
    }
    
    
    [self.tableview reloadData];
}


- (IBAction)deleteBtnClick:(id)sender {
    //删除
    
}
@end

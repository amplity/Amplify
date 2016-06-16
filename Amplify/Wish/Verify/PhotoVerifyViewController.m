//
//  PhotoVerifyViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/18.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "PhotoVerifyViewController.h"
#import "WishInfoModel.h"
#import "AddressConfirmView.h"
#import "OrderInfoView.h"
#import "CacheAddressModel.h"
#import "WishService.h"
#import "TWPhotoPickerController.h"
#import "ChangePhotoView.h"
#import "AddNewAddressView.h"
#import "WishShareView.h"
#import "ShareModel.h"
#import "WishAndComModel.h"
#import "AddressListView.h"

@interface PhotoVerifyViewController (){
    WishInfoModel * wishInfoModel;
}

@end

@implementation PhotoVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
}

-(void)initUI{
    
    
    wishInfoModel = self.inputViewData;
    
    [self.previewImage sd_setImageWithURL:[NSURL URLWithString:wishInfoModel.responseBody.imgurl]];
    
    
    [self layouPhotoView];
    
    [self initVerfyMessage];
    [self initVerifyInfo];
    [self initActivity];
    
    [self initVerifyTitle];
    [self initViewTitle];
    [self initVerifyTitleImage];
    [self initverifyLine];
    
    
    
    //上传成功提示
    if (wishInfoModel.isFormPhoto) {
        [JXAlertViewManage showViewWithAlert:@"提示" withInfo:@"上传成功!" withStatus:@""];
    }
    
}


//图片大小为方形
-(void)layouPhotoView{
    CGFloat slit = 15;
    self.view.frame =CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT);
    
    CGRect rect = CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT);
    self.wishVerifyViewBg.frame = rect;
    

    rect = CGRectMake(slit, slit, MAIN_SCREEN_WITH-slit*2, MAIN_SCREEN_HIGHT-slit*2);
    self.mainShowView.frame = rect;
    
    
    //添加滚动
    rect = CGRectMake(0, 0, MAIN_SCREEN_WITH-slit*2, MAIN_SCREEN_HIGHT-slit*2);
    self.mainScrollView.frame = rect;
    
    
    rect = CGRectMake(0, 0, MAIN_SCREEN_WITH-slit*2, 50);
    self.headView.frame = rect;
    
    
    //标题
    self.viewTitleLab.frame = CGRectMake(MAIN_SCREEN_WITH/2-290/2-slit, 0, 290, 50);
    self.viewTitleLab.textAlignment = NSTextAlignmentCenter;
    
    
    rect = CGRectMake(0, CGRectGetMaxY(self.headView.bounds), MAIN_SCREEN_WITH-slit*2, MAIN_SCREEN_WITH-slit*2);
    self.previewImage.frame = rect;
    
    rect = CGRectMake(MAIN_SCREEN_WITH-120-slit*2-8, CGRectGetMaxY(self.previewImage.bounds)+CGRectGetMaxY(self.headView.bounds)-50, 120, 30);
    self.changeBtn.frame = rect;
    
    //要居中,入围状态
    rect = CGRectMake(MAIN_SCREEN_WITH/2-290/2-slit, CGRectGetMaxY(self.previewImage.bounds)+CGRectGetMaxY(self.headView.bounds), 290, 120);
    self.verifyTitleLabView.frame = rect;
    
    
    
    //入围获奖
    rect = CGRectMake(MAIN_SCREEN_WITH/2-290/2-slit, CGRectGetMaxY(self.previewImage.bounds)+CGRectGetMaxY(self.headView.bounds)+CGRectGetMaxY(self.verifyTitleLabView.bounds)-30, 290, 140);
    self.votingView.frame = rect;
    
    //------------------------后续的动态变化--------------------
    
    NSInteger status = wishInfoModel.responseBody.status;
    
    if(status == WishInfoSuccess && [wishInfoModel.responseBody.address isEqualToString:@"3"]){//需要填写地址
        
        //活动时间
        rect = CGRectMake(30, CGRectGetMaxY(self.previewImage.bounds)+CGRectGetMaxY(self.headView.bounds)+CGRectGetMaxY(self.verifyTitleLabView.bounds)+CGRectGetMaxY(self.votingView.bounds), 260, 50);
        self.joinInfoView.frame = rect;
        
    }else{
        
        //活动时间
        rect = CGRectMake(30, CGRectGetMaxY(self.previewImage.bounds)+CGRectGetMaxY(self.headView.bounds)+CGRectGetMaxY(self.verifyTitleLabView.bounds)+20, 260, 50);
        self.joinInfoView.frame = rect;

    }
    
    
    //contentSize的 height
    CGFloat contentSizeHeight = 0;
    contentSizeHeight = self.joinInfoView.frame.origin.y + CGRectGetMaxY(self.joinInfoView.bounds);
    self.mainScrollView.contentSize = CGSizeMake(290, contentSizeHeight);
    
    
    //分割线
    rect = CGRectMake(10, self.joinInfoView.frame.origin.y, MAIN_SCREEN_WITH-slit*2-20, 1);
    self.joinInfoLine.frame = rect;
}


/**
 *  view 标题
 */
-(void)initViewTitle{
    NSInteger status = wishInfoModel.responseBody.status;
    int num = status/10.0;
    self.viewTitleLab.text = NSLocalizedString(@"uploadSuccess", nil);
    
    switch (num) {
        case 0:
            self.viewTitleLab.text = NSLocalizedString(@"uploadSuccess", nil);
            break;
        case 1:
            self.viewTitleLab.text = NSLocalizedString(@"joinSuccess", nil);
            break;
        case 2:
            self.viewTitleLab.text = NSLocalizedString(@"verifyEnd", nil);
            break;
            
        default:
            break;
    }
}


/**
 *  设置审核状态信息
 */
-(void)initVerfyMessage{
    NSInteger status = wishInfoModel.responseBody.status;
    
    self.votingView.hidden = YES;
    self.verifyMessageLab.hidden = NO;
    
    
    if (status == WishInfoJoin) {
        self.verifyMessageLab.text = wishInfoModel.responseBody.desc;
    }else if(status == WishInfNotCome){
        self.verifyMessageLab.text = wishInfoModel.responseBody.desc;
    }else if(status == WishInfoCome){
        self.verifyMessageLab.text = wishInfoModel.responseBody.desc;
    }else if(status == WishInfoUnSuccess){
        self.verifyMessageLab.text = wishInfoModel.responseBody.desc;
    }else if(status == WishInfoSuccessDotSend){
        self.verifyMessageLab.text = wishInfoModel.responseBody.desc;
    }else if(status == WishInfoSuccess){
        if ([wishInfoModel.responseBody.address isEqualToString:@"3"]) {
            self.votingView.hidden = YES;
        }else{
            self.votingView.hidden = NO;
        }
        
        self.verifyMessageLab.hidden = YES;
    }
    
    
    self.changeBtn.hidden = YES;
    if (wishInfoModel.responseBody.flag ==1 || wishInfoModel.responseBody.flag == 3) {
        self.changeBtn.hidden = NO;
    }
}


/**
 *  审核标题状态颜色
 */
-(void)initVerifyTitle{
    __weak typeof(self) weakSelf = self;
    
    
    NSInteger status = wishInfoModel.responseBody.status;
    self.verifyTitleLab.textColor = [UIColor grayColor];
    self.verifyTitleLab2.textColor = [UIColor grayColor];
    self.verifyTitleLab3.textColor = [UIColor grayColor];
    
    int num = status/10.0;
    switch (num) {
        case 0:
            self.verifyTitleLab.textColor = [UIColor redColor];
            break;
        case 1:
            self.verifyTitleLab2.textColor = [UIColor redColor];
            break;
        case 2:
            self.verifyTitleLab3.textColor = [UIColor redColor];
            break;
            
        default:
            break;
    }
}


/**
 *  审核状态提示
 */
-(void)initVerifyInfo{
    NSInteger status = wishInfoModel.responseBody.status;
    self.verifyInfoLab.text = @"";
    self.verifyInfoLab2.text = @"";
    self.verifyInfoLab3.text = @"";
    
    self.verifyInfoLab.hidden = YES;
    self.verifyInfoLab2.hidden = YES;
    self.verifyInfoLab3.hidden = YES;
    
    
    if (status == WishInfoJoin) {
        self.verifyInfoLab.text = [NSString stringWithFormat:NSLocalizedString(@"getIntegral", nil),wishInfoModel.responseBody.uploadjf];
        self.verifyInfoLab.hidden = NO;
    }else if(status == WishInfNotCome){
        self.verifyInfoLab2.text = NSLocalizedString(@"verifyInfoLab2Fail", nil);
        self.verifyInfoLab2.hidden = NO;
    }else if(status == WishInfoCome){
        self.verifyInfoLab2.text = NSLocalizedString(@"verifyInfoLab2Success", nil);
        self.verifyInfoLab2.hidden = NO;
    }else if(status == WishInfoUnSuccess){
        self.verifyInfoLab3.text = [NSString stringWithFormat:NSLocalizedString(@"verifyInfoLab3", nil),wishInfoModel.responseBody.passjf];
        self.verifyInfoLab3.hidden = NO;
    }else if(status == WishInfoSuccessDotSend){
        self.verifyInfoLab3.text = NSLocalizedString(@"verifyInfoLabUnSend3", nil);
        self.verifyInfoLab3.hidden = NO;
    }else if(status == WishInfoSuccess){
        
        if ([wishInfoModel.responseBody.address isEqualToString:@"3"]) {
            self.verifyInfoLab3.text = NSLocalizedString(@"verifyInfoLab3SuccessOrder", nil);
        }else{
            self.verifyInfoLab3.text = NSLocalizedString(@"verifyInfoLab3Success", nil);
        }
        self.verifyInfoLab3.hidden = NO;
    }
    
    
}


/**
 *  审核状态image
 */
-(void)initVerifyTitleImage{
    NSInteger status = wishInfoModel.responseBody.status;
    
    self.verifyTitleImage.hidden = YES;
    self.verifyTitleImage2.hidden = YES;
    self.verifyTitleImage3.hidden = YES;
    
    if (status == WishInfoJoin) {
        self.verifyTitleImage.hidden = NO;
        self.verifyTitleImage.image = [UIImage imageNamed:@"wishSuccess"];
    }else if(status == WishInfNotCome){
        self.verifyTitleImage.hidden = NO;
        self.verifyTitleImage.image = [UIImage imageNamed:@"wishSuccess"];
        self.verifyTitleImage2.hidden = NO;
        self.verifyTitleImage2.image = [UIImage imageNamed:@"wishX"];
    }else if(status == WishInfoCome){
        self.verifyTitleImage.hidden = NO;
        self.verifyTitleImage.image = [UIImage imageNamed:@"wishSuccess"];
        self.verifyTitleImage2.hidden = NO;
        self.verifyTitleImage2.image = [UIImage imageNamed:@"wishSuccess"];
    }else if(status == WishInfoUnSuccess){
        self.verifyTitleImage.hidden = NO;
        self.verifyTitleImage.image = [UIImage imageNamed:@"wishSuccess"];
        self.verifyTitleImage2.hidden = NO;
        self.verifyTitleImage2.image = [UIImage imageNamed:@"wishSuccess"];
        self.verifyTitleImage3.hidden = NO;
        self.verifyTitleImage3.image = [UIImage imageNamed:@"wishEnd"];
    }else if(status == WishInfoSuccessDotSend){
        self.verifyTitleImage.hidden = NO;
        self.verifyTitleImage.image = [UIImage imageNamed:@"wishSuccess"];
        self.verifyTitleImage2.hidden = NO;
        self.verifyTitleImage2.image = [UIImage imageNamed:@"wishSuccess"];
        self.verifyTitleImage3.hidden = NO;
        self.verifyTitleImage3.image = [UIImage imageNamed:@"wishX"];
    
    }else if(status == WishInfoSuccess){
        self.verifyTitleImage.hidden = NO;
        self.verifyTitleImage.image = [UIImage imageNamed:@"wishSuccess"];
        self.verifyTitleImage2.hidden = NO;
        self.verifyTitleImage2.image = [UIImage imageNamed:@"wishSuccess"];
        self.verifyTitleImage3.hidden = NO;
        self.verifyTitleImage3.image = [UIImage imageNamed:@"wishWin"];
    }
    
}

/**
 *  审核状态线
 */
-(void)initverifyLine{
    NSInteger status = wishInfoModel.responseBody.status;
    int num = status/10.0;
    
    
    self.verifyLine2.hidden = YES;
    self.verifyLine.hidden = YES;
    
    switch (num) {
        case 1:
            self.verifyLine.hidden = NO;
            break;
        case 2:
            self.verifyLine2.hidden = NO;
            self.verifyLine.hidden = NO;
            break;
            
        default:
            break;
    }
    
}


/**
 *  参与活动信息
 */
-(void)initActivity{
    self.activityLab.text = [NSString stringWithFormat:@"%@",wishInfoModel.responseBody.resttime];
    
    self.activityNumLab.text = [NSString stringWithFormat:@"%@%@",wishInfoModel.responseBody.joinNum,NSLocalizedString(@"activityNumLab", nil)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if( self.view.window == nil && [self isViewLoaded]) {
        
        //安全移除控制器的view;
        
        self.view = nil;
        
    }
}

- (IBAction)addressBtnClick:(id)sender {
    WishAndComModel * wishAndComModel = [[WishAndComModel alloc] init];
    wishAndComModel.wishId = wishInfoModel.responseBody.wishId;
    wishAndComModel.comId = wishInfoModel.responseBody.comId;
    
    
    //地址选择
    AddressListView * addressListView = [AddressListView instancesViewWithBaseModel:wishAndComModel];
    addressListView.baseViewDelegate = self;
    [self.view.window addSubview:addressListView];
}


- (IBAction)shareBtnClick:(id)sender {
    
    ShareModel * shareModel = [[ShareModel alloc] init];
    shareModel.type = @"2";
    shareModel.wishId = wishInfoModel.responseBody.wishId;
    WishShareView * wishShareView = [WishShareView instancesViewWithBaseModel:shareModel];
    [self.view.window addSubview:wishShareView];
    
}
- (IBAction)closeBtnClick:(id)sender {
    
    
    //返回到详情页
    NSMutableArray * array =[[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    //删除最后一个，也就是自己
    [array removeObjectAtIndex:array.count-1];
    

    
    BaseViewController * navViewCon;
    for (navViewCon in array) {
        NSString * classStr = NSStringFromClass([navViewCon class]);
        if ([classStr isEqualToString:@"WishInfoViewController"] ) {
            break;
        }
    }
    
    [self.navigationController popToViewController:navViewCon animated:NO];
}
- (IBAction)changeBtnClick:(id)sender {
    
    ChangePhotoView * changePhotoView = [ChangePhotoView instancesViewWithBaseModel:nil];
    changePhotoView.baseViewDelegate = self;
    [self.view.window addSubview:changePhotoView];
    
    [self showCGAffineTransform];

}

-(void)showCGAffineTransform{
    self.mainShowView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.5 animations:^{
        self.mainShowView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        self.mainShowView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}


#pragma mark - BaseViewDelegate
-(void)baseViewClickToController:(NSString *)clickEventName withObject:(id)object{
    if ([clickEventName isEqualToString:@"wishAddressViewOkBtnClick"]) {//地址点击
        AddressConfirmView * addressConfirmView = [AddressConfirmView instancesViewWithBaseModel:object];
        addressConfirmView.baseViewDelegate = self;
        [self.view.window addSubview:addressConfirmView];
    }else if([clickEventName isEqualToString:@"wishEditBtnClick"]){//修改地址
        CacheAddressModel * cacheAddressModel = (CacheAddressModel*)object;
        AddNewAddressView * addressView = [AddNewAddressView instancesViewWithBaseModel:cacheAddressModel];
        addressView.baseViewDelegate = self;
        [self.view.window addSubview:addressView];
    }else if([clickEventName isEqualToString:@"wishAddressConfirmViewOkBtnClick"]){
        OrderInfoView * orderInfoView = [OrderInfoView instancesViewWithBaseModel:object];
        orderInfoView.baseViewDelegate = self;
        [self.view.window addSubview:orderInfoView];
    }else if([clickEventName isEqualToString:@"wishChangePhotoOkBtnClick"]){
        
        self.mainShowView.transform = CGAffineTransformMakeScale(1, 1);
        //上传
        NSString * wishid = wishInfoModel.responseBody.wishId;
        TWPhotoPickerController * photoPickerViewController = [[TWPhotoPickerController alloc] init];
        photoPickerViewController.inputViewData = wishid;
        [self.navigationController pushViewController:photoPickerViewController animated:YES];
        
    }else if([clickEventName isEqualToString:@"wishChangePhotoCancleBtnClick"]){
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, .3*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            self.mainShowView.transform = CGAffineTransformMakeScale(1, 1);
        });
        
    }else if([clickEventName isEqualToString:@"OrderInfoViewNextClick"]){
        //分享
        dispatch_async(dispatch_get_main_queue(), ^{
            ShareModel * shareModel = [[ShareModel alloc] init];
            shareModel.type = @"2";
            shareModel.wishId = wishInfoModel.responseBody.wishId;
            shareModel.isEndShare = YES;
            WishShareView * wishShareView = [WishShareView instancesViewWithBaseModel:shareModel];
            wishShareView.baseViewDelegate = self;
            [self.view.window addSubview:wishShareView];
        });
    }else if([clickEventName isEqualToString:@"addBtnClick"]){//新增地址
        dispatch_async(dispatch_get_main_queue(), ^{
            WishAndComModel * wishAndComModel = [[WishAndComModel alloc] init];
            wishAndComModel.wishId = wishInfoModel.responseBody.wishId;
            wishAndComModel.comId = wishInfoModel.responseBody.comId;
            AddNewAddressView * addressView = [AddNewAddressView instancesViewWithBaseModel:nil];
            addressView.baseViewDelegate = self;
            [self.view.window addSubview:addressView];
        });

    }else if([clickEventName isEqualToString:@"addressListViewClick"]){//地址选中,到确认地址
        AddressConfirmView * addressConfirmView = [AddressConfirmView instancesViewWithBaseModel:object];
        addressConfirmView.baseViewDelegate = self;
        [self.view.window addSubview:addressConfirmView];
    }
    
    //流程结束
    else if([clickEventName isEqualToString:@"photoVerifyVIewEnd"]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end

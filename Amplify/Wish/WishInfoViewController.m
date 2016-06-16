//
//  WishInfoViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/30.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "WishInfoViewController.h"
#import "WishService.h"
#import "WishInfoModel.h"
#import "PhotoVerifyViewController.h"
#import "TWPhotoPickerController.h"
#import "WishNextViewController.h"
#import "LookForShareFrameView.h"
#import "WishShareView.h"
#import "ShareModel.h"
#import "LoginViewController.h"
#import "DiscoverNoBarWebController.h"
#import "LinkModel.h"

@interface WishInfoViewController (){
    ShareModel * shareModel;
    
    NSString * wishid;
}

@end

@implementation WishInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSString * comWishUrl = [NSString stringWithFormat:@"%@&token=%@",self.inputViewData,[UserManager token]];
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:comWishUrl withParameter:nil];
    [self.baseWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:comUrl] ]];
    
    shareModel = [[ShareModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if( self.view.window == nil && [self isViewLoaded]) {
        
        //安全移除控制器的view;
        
        self.view = nil;
        
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [super webViewDidFinishLoad:webView];
    //js例子
    BaseWebView * currentWebView = (BaseWebView*)webView;
    
    
    //wishId
    NSObject * jsObject = [[BaseWebManager shareWebManager] fixJavascriptDataByFun:@"getWishId()" withWebView:currentWebView];
    wishid = (NSString*)jsObject;
    
    shareModel.wishId = wishid;
    
    
    [[BaseWebManager shareWebManager] sendJsDataForObjcet:@"$m_app_getUrl" withWebView:currentWebView withBlock:^(id jsToObject) {
        
        NSArray * jsObjectArr = (NSArray *)jsToObject;
        
        if (jsObjectArr.count>0) {
            NSString * keyStr = [jsObjectArr objectAtIndex:0];
            
            if ([keyStr isEqualToString:@"joinin"]) {//用户参加活动信息
                wishid = [jsToObject objectAtIndex:1];
                if ([UserManager isLogin]) {
                    
                    if ([UserManager inviteWish]) {
                        [self joinActivity];
                    }else{
                        [TipManager showTipsWithInforStr:@"请先获得邀请" withAfter:1.0];
                    }
                    
                }else{
                    LoginViewController * loginViewController = [[LoginViewController alloc] init];
                    loginViewController.loginRestltDelegate = self;
                    [self.navigationController pushViewController:loginViewController animated:YES];
                }
            }else if ([keyStr isEqualToString:@"rule"]) {//活动规则
                NSString * infoUrl = [jsToObject objectAtIndex:1];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    WishNextViewController * wishNextViewController = [[WishNextViewController alloc] init];
                    wishNextViewController.inputViewData = infoUrl;
                    wishNextViewController.navigationItem.title = @"心愿活动规则";
                    [self.navigationController pushViewController:wishNextViewController animated:YES];
                });
            }else if ([keyStr isEqualToString:@"brandDetail"]) {//品牌详情
                NSString * infoUrl = [jsToObject objectAtIndex:1];
                dispatch_async(dispatch_get_main_queue(), ^{
                    DiscoverNoBarWebController * discoverNoBarWebController = [[DiscoverNoBarWebController alloc] init];
                    LinkModel * linkModel = [[LinkModel alloc] init];
//                    linkModel.titleStr = @"品牌详情";
                    linkModel.url = infoUrl;
                    discoverNoBarWebController.inputViewData = linkModel;
                    [self.navigationController pushViewController:discoverNoBarWebController animated:YES];
                });
            }else if ([keyStr isEqualToString:@"backevent"]) {//放回
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else if([keyStr isEqualToString:@"likeevent"]){//收藏
                [TipManager showTipsWithInforStr:NSLocalizedString(@"storeSuccess", nil) withAfter:1.0];
            }else if([keyStr isEqualToString:@"shareevent"]){//分享
                dispatch_async(dispatch_get_main_queue(), ^{
                    shareModel.type = @"1";
                    WishShareView * wishShareView = [WishShareView instancesViewWithBaseModel:shareModel];
                    wishShareView.baseViewDelegate = self;
                    [self.view.window addSubview:wishShareView];
                });
            }

        }
        
        
    }];
  
}

//参与活动
-(void)joinActivity{
    [WishService upinfo:wishid withHandler:^(id responseObj) {
        WishInfoModel * wishInfoModel = [WishInfoModel mj_objectWithKeyValues:responseObj];
        
        if ([wishInfoModel.responseHead.code isEqualToString:@"00000"]) {
            if (wishInfoModel.responseBody.flag==3) {
                TWPhotoPickerController * photoPickerViewController = [[TWPhotoPickerController alloc] init];
                photoPickerViewController.inputViewData = wishid;
                
                
                [self.navigationController pushViewController:photoPickerViewController animated:YES];
            }else{
                PhotoVerifyViewController * photoVerifyViewController = [[PhotoVerifyViewController alloc] init];
                photoVerifyViewController.inputViewData = wishInfoModel;
                
                [self.navigationController pushViewController:photoVerifyViewController animated:YES];
                
            }
            
        }
        
    } withHandler:^(NSError *error) {
        
    }];
}

#pragma mark - LoginResultDelegate
-(void)showLoginResult:(BOOL)isSuccess withClickStr:(NSString *)clickStr{
    if (isSuccess) {
        [self joinActivity];
    }
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

@end

//
//  PayChangeWebViewLoadViewController.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/15.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "PayChangeWebViewLoadViewController.h"
#import "DiscoveryService.h"
#import "PayChangeData.h"
#import "PayResultWeViewController.h"

#import "AlipayModel.h"

@interface PayChangeWebViewLoadViewController (){
    PayChangeData * payChangeData;
    
    
    NSString * testStr;
    
}

@end

@implementation PayChangeWebViewLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"支付方式";
    
    
//    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_tool"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClick)];
//    
//    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:self.inputViewData withParameter:nil];
    
    [self.baseWebView baseLoadRequest:comUrl];
    
    testStr=comUrl;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if( self.view.window == nil && [self isViewLoaded]) {
        
        //安全移除控制器的view;
        
        self.view = nil;
        
    }
}



-(void)onGoLeft{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"必须在60分钟以内支付，否则订单自动取消" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    alertView.tag = 10001;
    [alertView show];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
    
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
    
}


#pragma  mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag ==10001) {
        if (buttonIndex==0) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


#pragma  mark - AlipayHKDelegate
-(void)paymentResultDelegate:(NSString *)result withObject:(id)obj{
    NSString * oderId = (NSString*)obj;
    if (result.intValue == 6001) {//取消
        
    }else if(result.intValue == 9000){//成功
        PayResultWeViewController * payResultWeViewController= [[PayResultWeViewController alloc] init];
        payResultWeViewController.inputViewData = [NSString stringWithFormat:@"/app/pay/payCheckHK?orderId=%@",oderId];
        
        [self.navigationController pushViewController:payResultWeViewController animated:YES];
    }else if(result.intValue == 4000){//失败
        
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

@end

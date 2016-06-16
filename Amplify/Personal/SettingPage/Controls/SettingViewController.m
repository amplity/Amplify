//
//  SettingViewController.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/3.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "SettingViewController.h"
#import "HelpViewController.h"
#import "HomTabBarController.h"
#import "HelpWebViewController.h"
#import "HelpObject.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"设置";

    self.versonLab.text = [NSString stringWithFormat:@"v%@     ",[UserManager version]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)useBtnClick:(id)sender {
    
    HelpObject * helpObject = [[HelpObject alloc] init];
    HelpWebViewController * helpWebViewController = [[HelpWebViewController alloc] init];
    helpObject.titileNameStr = @"关于我们";
    helpObject.httpUrl = @"/aboutUs";
    helpWebViewController.inputViewData = helpObject;
    [self.navigationController pushViewController:helpWebViewController animated:YES];
    
}
- (IBAction)helpeBtnClick:(id)sender {
    
    
    HelpViewController * helpViewController = [[HelpViewController alloc] init];

    [self.navigationController pushViewController:helpViewController animated:YES];
}
- (IBAction)reciveBtnClick:(id)sender {
}
- (IBAction)declareBtnClick:(id)sender {
    HelpObject * helpObject = [[HelpObject alloc] init];
    HelpWebViewController * helpWebViewController = [[HelpWebViewController alloc] init];
    helpObject.titileNameStr = @"免责申明";
    helpObject.httpUrl = @"/disclaimer";
    helpWebViewController.inputViewData = helpObject;
    [self.navigationController pushViewController:helpWebViewController animated:YES];
    
}
- (IBAction)giveMark:(id)sender {
//    https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/924898454
//    NSString *str = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", @"924898454"];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=924898454&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
}

- (IBAction)outBtnClick:(id)sender {
    //退出
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
    [UserManager quitApp];
    [[HomTabBarController shareInstance] changeBarViewController:@"0"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.delegate = nil;
}
@end

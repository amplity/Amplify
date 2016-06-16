//
//  SettingViewController.h
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/3.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *versonLab;
//关于我们
- (IBAction)useBtnClick:(id)sender;

//帮助中心
- (IBAction)helpeBtnClick:(id)sender;

//反馈信息
- (IBAction)reciveBtnClick:(id)sender;

//推送
@property (weak, nonatomic) IBOutlet UISwitch *senBtn;

//免责声明
- (IBAction)declareBtnClick:(id)sender;

//评分
- (IBAction)giveMark:(id)sender;

- (IBAction)outBtnClick:(id)sender;

@end

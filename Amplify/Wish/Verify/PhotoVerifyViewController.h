//
//  PhotoVerifyViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/18.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"

@interface PhotoVerifyViewController : BaseViewController<BaseViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *previewImage;

//头部
@property (weak, nonatomic) IBOutlet UIView *headView;
//剩余信息
@property (weak, nonatomic) IBOutlet UIView *joinInfoView;
//背景
@property (weak, nonatomic) IBOutlet UIImageView *wishVerifyViewBg;
//分割线
@property (weak, nonatomic) IBOutlet UIImageView *joinInfoLine;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;


@property (weak, nonatomic) IBOutlet UILabel *verifyTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *verifyTitleLab2;
@property (weak, nonatomic) IBOutlet UILabel *verifyTitleLab3;
@property (weak, nonatomic) IBOutlet UIView *verifyTitleLabView;

@property (weak, nonatomic) IBOutlet UIImageView *verifyTitleImage;
@property (weak, nonatomic) IBOutlet UIImageView *verifyTitleImage2;
@property (weak, nonatomic) IBOutlet UIImageView *verifyTitleImage3;

@property (weak, nonatomic) IBOutlet UIImageView *verifyLine;
@property (weak, nonatomic) IBOutlet UIImageView *verifyLine2;

@property (weak, nonatomic) IBOutlet UILabel *verifyInfoLab;
@property (weak, nonatomic) IBOutlet UILabel *verifyInfoLab2;
@property (weak, nonatomic) IBOutlet UILabel *verifyInfoLab3;

@property (weak, nonatomic) IBOutlet UILabel *verifyMessageLab;

//审核结果
@property (weak, nonatomic) IBOutlet UIView *votingView;
@property (weak, nonatomic) IBOutlet UILabel *WinningInfoLab;
- (IBAction)addressBtnClick:(id)sender;
- (IBAction)shareBtnClick:(id)sender;

//
@property (weak, nonatomic) IBOutlet UILabel *activityLab;
@property (weak, nonatomic) IBOutlet UILabel *activityNumLab;


//关闭
- (IBAction)closeBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *viewTitleLab;


@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
- (IBAction)changeBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *mainShowView;

@end

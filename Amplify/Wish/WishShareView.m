//
//  WishShareView.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/27.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "WishShareView.h"
#import "WishShareModel.h"
#import "WishService.h"
#import "ShareModel.h"
#import "HomTabBarController.h"

@implementation WishShareView

-(void)initBaseView:(BaseView*)baseView{
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT);
}

- (IBAction)cancleClick:(id)sender {
    [self removeFromSuperview];
    
    ShareModel * shareModel =(ShareModel*)self.baseViewModel;
    
    if (shareModel.isEndShare) {
        [self shareEndShowFrame];
    }
}

- (IBAction)wxFriendClick:(id)sender {
//    [self baseViewClickToController:@"LookForViewWxFriendClick" withObject:nil];
    
    if (![[ThridPartManager manager] isWeixinInstall]) {
        [TipManager showTipsWithInforStr:@"请安装微信" withAfter:1.0];
        return;
    }
    
    ShareModel * shareModel =(ShareModel*)self.baseViewModel;
    
    
    [WishService wishShare:shareModel.wishId withType:shareModel.type withChannel:@"2" withHandler:^(id responseObj) {
        WishShareModel * wishShareModel = [WishShareModel mj_objectWithKeyValues:responseObj];
        if ([wishShareModel.responseHead.code isEqualToString:@"00000"]) {
            [[ThridPartManager manager] weixinShare:wishShareModel.responseBody.title withInfoStr:wishShareModel.responseBody.desc withIcon:wishShareModel.responseBody.imgurl withUrl:wishShareModel.responseBody.shareurl];
        }
        
    } withHandler:^(NSError *error) {
        
    }];
    
}

- (IBAction)wxGroundClick:(id)sender {
    
    if (![[ThridPartManager manager] isWeixinInstall]) {
        [TipManager showTipsWithInforStr:@"请安装微信" withAfter:1.0];
        return;
    }
    
    ShareModel * shareModel =(ShareModel*)self.baseViewModel;
    
    
    [WishService wishShare:shareModel.wishId withType:shareModel.type withChannel:@"2" withHandler:^(id responseObj) {
        WishShareModel * wishShareModel = [WishShareModel mj_objectWithKeyValues:responseObj];
        if ([wishShareModel.responseHead.code isEqualToString:@"00000"]) {
            
            [[ThridPartManager manager] weixinQunShare:wishShareModel.responseBody.title withInfoStr:wishShareModel.responseBody.desc withIcon:wishShareModel.responseBody.imgurl withUrl:wishShareModel.responseBody.shareurl];
        }
    } withHandler:^(NSError *error) {
        
    }];
}

- (IBAction)xlWbClick:(id)sender {
    
    ShareModel * shareModel =(ShareModel*)self.baseViewModel;
    
    
    [WishService wishShare:shareModel.wishId withType:shareModel.type withChannel:@"1" withHandler:^(id responseObj) {
        WishShareModel * wishShareModel = [WishShareModel mj_objectWithKeyValues:responseObj];
        if ([wishShareModel.responseHead.code isEqualToString:@"00000"]) {
            
            [[ThridPartManager manager] weboShare:wishShareModel.responseBody.title withInfoStr:wishShareModel.responseBody.desc withIcon:wishShareModel.responseBody.imgurl withUrl:wishShareModel.responseBody.shareurl];
        }
        
    } withHandler:^(NSError *error) {
        
    }];
 
}

- (IBAction)qqGroundClick:(id)sender {
    
    if (![[ThridPartManager manager] isQQInstall]) {
        [TipManager showTipsWithInforStr:@"请安装QQ" withAfter:1.0];
        return;
    }
    
    ShareModel * shareModel =(ShareModel*)self.baseViewModel;
    
    
    [WishService wishShare:shareModel.wishId withType:shareModel.type withChannel:@"3" withHandler:^(id responseObj) {
        WishShareModel * wishShareModel = [WishShareModel mj_objectWithKeyValues:responseObj];
        if ([wishShareModel.responseHead.code isEqualToString:@"00000"]) {
            
            [[ThridPartManager manager] qqShare:wishShareModel.responseBody.title withInfoStr:wishShareModel.responseBody.desc withIcon:wishShareModel.responseBody.imgurl withUrl:wishShareModel.responseBody.shareurl];
        }
        
    } withHandler:^(NSError *error) {
        
    }];
    
}


//分享后,或者取消
-(void)shareEndShowFrame{
    [self baseViewClickToController:@"photoVerifyVIewEnd" withObject:nil];
}
@end

//
//  LookForShareFrameView.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "LookForShareFrameView.h"
#import "LookForService.h"
#import "ShareModel.h"
#import "LookForShareModel.h"
#import "LoginViewController.h"

@implementation LookForShareFrameView

-(void)initBaseView:(BaseView*)baseView{
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT);
}

- (IBAction)cancleClick:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)wxFriendClick:(id)sender {
    
    if (![[ThridPartManager manager] isWeixinInstall]) {
        [TipManager showTipsWithInforStr:@"请安装微信" withAfter:1.0];
        return;
    }
    
    ShareModel * shareModel =(ShareModel*)self.baseViewModel;
    
    [LookForService lookForShare:shareModel.businessId withType:[NSString stringWithFormat:@"%d",LookForShareLookFor] withChannel:@"2" withHandler:^(id responseObj) {
        LookForShareModel * lookForShareModel = [LookForShareModel mj_objectWithKeyValues:responseObj];
        
        
        if ([lookForShareModel.responseHead.code isEqualToString:@"00000"]) {
            [[ThridPartManager manager] weixinShare:lookForShareModel.responseBody.title withInfoStr:lookForShareModel.responseBody.content withIcon:lookForShareModel.responseBody.imageUrl withUrl:lookForShareModel.responseBody.url];
        }else{
            [TipManager showTipsWithInforStr:lookForShareModel.responseHead.msg withAfter:1.0];
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
    
    [LookForService lookForShare:shareModel.businessId withType:[NSString stringWithFormat:@"%d",LookForShareLookFor] withChannel:@"2" withHandler:^(id responseObj) {
        LookForShareModel * lookForShareModel = [LookForShareModel mj_objectWithKeyValues:responseObj];
        
        
        if ([lookForShareModel.responseHead.code isEqualToString:@"00000"]) {
            [[ThridPartManager manager] weixinQunShare:lookForShareModel.responseBody.title withInfoStr:lookForShareModel.responseBody.content withIcon:lookForShareModel.responseBody.imageUrl withUrl:lookForShareModel.responseBody.url];
        }else{
            [TipManager showTipsWithInforStr:lookForShareModel.responseHead.msg withAfter:1.0];
        }
        
        
    } withHandler:^(NSError *error) {
        
    }];
}

- (IBAction)xlWbClick:(id)sender {
    
    
    ShareModel * shareModel =(ShareModel*)self.baseViewModel;
    
    [LookForService lookForShare:shareModel.businessId withType:[NSString stringWithFormat:@"%d",LookForShareLookFor] withChannel:@"1" withHandler:^(id responseObj) {
        LookForShareModel * lookForShareModel = [LookForShareModel mj_objectWithKeyValues:responseObj];
        
        
        if ([lookForShareModel.responseHead.code isEqualToString:@"00000"]) {
            [[ThridPartManager manager] weboShare:lookForShareModel.responseBody.title withInfoStr:lookForShareModel.responseBody.content withIcon:lookForShareModel.responseBody.imageUrl withUrl:lookForShareModel.responseBody.url];
        }else{
            [TipManager showTipsWithInforStr:lookForShareModel.responseHead.msg withAfter:1.0];
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
    
    [LookForService lookForShare:shareModel.businessId withType:[NSString stringWithFormat:@"%d",LookForShareLookFor] withChannel:@"3" withHandler:^(id responseObj) {
        LookForShareModel * lookForShareModel = [LookForShareModel mj_objectWithKeyValues:responseObj];
        
        if ([lookForShareModel.responseHead.code isEqualToString:@"00000"]) {
            [[ThridPartManager manager] qqShare:lookForShareModel.responseBody.title withInfoStr:lookForShareModel.responseBody.content withIcon:lookForShareModel.responseBody.imageUrl withUrl:lookForShareModel.responseBody.url];
        }else{
            [TipManager showTipsWithInforStr:lookForShareModel.responseHead.msg withAfter:1.0];
        }

        
        
    } withHandler:^(NSError *error) {
        
    }];
}


@end

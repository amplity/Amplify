//
//  OrderInfoView.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/1.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseView.h"

@interface OrderInfoView : BaseView
- (IBAction)closeBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *orderInfoLab;
@property (weak, nonatomic) IBOutlet UILabel *orderMessageLab;
- (IBAction)nextBtnClick:(id)sender;

@end

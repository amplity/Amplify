//
//  ChangePhotoView.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/20.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseView.h"

@interface ChangePhotoView : BaseView
@property (weak, nonatomic) IBOutlet UIButton *cancleBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UILabel *changeInfo;
- (IBAction)cancleBtnClick:(id)sender;
- (IBAction)changeBtnClick:(id)sender;

@end

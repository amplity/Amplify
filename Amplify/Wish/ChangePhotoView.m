//
//  ChangePhotoView.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/20.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "ChangePhotoView.h"

@implementation ChangePhotoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)initBaseView:(BaseView *)baseView{
    self.frame = CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT);
    self.changeInfo.text = NSLocalizedString(@"reUploadInfo", nil);
}

- (IBAction)cancleBtnClick:(id)sender {
    [self baseViewClickToController:@"wishChangePhotoCancleBtnClick" withObject:nil];
    [self removeFromSuperview];
}

- (IBAction)changeBtnClick:(id)sender {
    
    [self baseViewClickToController:@"wishChangePhotoOkBtnClick" withObject:nil];
    [self removeFromSuperview];
}
@end

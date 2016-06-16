//
//  LookForShareFrameView.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface LookForShareFrameView : BaseView

@property (weak, nonatomic) IBOutlet UIView *wxFriend;

@property (weak, nonatomic) IBOutlet UIView *wxGround;
@property (weak, nonatomic) IBOutlet UIView *xlWb;
@property (weak, nonatomic) IBOutlet UIView *qqGround;

- (IBAction)cancleClick:(id)sender;

- (IBAction)wxFriendClick:(id)sender;

- (IBAction)wxGroundClick:(id)sender;

- (IBAction)xlWbClick:(id)sender;

- (IBAction)qqGroundClick:(id)sender;
@end

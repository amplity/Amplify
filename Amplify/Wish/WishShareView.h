//
//  WishShareView.h
//  Amplify
//
//  Created by ZhangJixu on 16/4/27.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseView.h"

@interface WishShareView : BaseView


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

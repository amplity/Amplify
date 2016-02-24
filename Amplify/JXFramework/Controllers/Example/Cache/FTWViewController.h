//
//  FTWViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/24.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"

@interface FTWViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end

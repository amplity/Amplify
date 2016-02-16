//
//  BootViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/14.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"

@interface BootViewController : BaseViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *bagScrollView;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
- (IBAction)bootBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

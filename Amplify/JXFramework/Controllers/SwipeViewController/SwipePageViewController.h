//
//  SwipePageViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"

@interface SwipePageViewController : BaseViewController<UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSArray *pageContent;

@end

//
//  SwipePageViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/15.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "SwipePageViewController.h"
#import "MoreViewController.h"

@interface SwipePageViewController ()

@end


@implementation SwipePageViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self createContentPages];// 初始化所有数据
    // 设置UIPageViewController的配置项
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                       forKey: UIPageViewControllerOptionSpineLocationKey];
    
    // 实例化UIPageViewController对象，根据给定的属性
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options: options];
    // 设置UIPageViewController对象的代理
    _pageController.dataSource = self;
    // 定义“这本书”的尺寸
    [[_pageController view] setFrame:[[self view] bounds]];
    
    // 让UIPageViewController对象，显示相应的页数据。
    // UIPageViewController对象要显示的页数据封装成为一个NSArray。
    // 因为我们定义UIPageViewController对象显示样式为显示一页（options参数指定）。
    // 如果要显示2页，NSArray中，应该有2个相应页数据。
    MoreViewController *initialViewController =[self viewControllerAtIndex:0];// 得到第一页
    NSArray *viewControllers =[NSArray arrayWithObject:initialViewController];
    [_pageController setViewControllers:viewControllers
                              direction:UIPageViewControllerNavigationDirectionForward
                               animated:NO
                             completion:nil];
    
    // 在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 初始化所有数据
- (void) createContentPages {
    
    NSMutableArray *pageStrings = [[NSMutableArray alloc] init];
    for (int i = 1; i < 11; i++){
        NSString *contentString = [[NSString alloc] initWithFormat:@"Chapter %d This is the page %d of content displayed using UIPageViewController in iOS 5.", i, i];
        [pageStrings addObject:contentString];
    }
    
    self.pageContent = [[NSArray alloc] initWithArray:pageStrings];
}


// 得到相应的VC对象
- (MoreViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.pageContent count] == 0) || (index >= [self.pageContent count])) {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    MoreViewController *dataViewController =[[MoreViewController alloc] init];
    dataViewController.dataObject =[self.pageContent objectAtIndex:index];
    return dataViewController;
}

// 根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(MoreViewController *)viewController {
    return [self.pageContent indexOfObject:viewController.dataObject];
}



#pragma mark- UIPageViewControllerDataSource

// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法，自动来维护次序。
    // 不用我们去操心每个ViewController的顺序问题。
    return [self viewControllerAtIndex:index];
    
    
}

// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    NSUInteger index = [self indexOfViewController:(MoreViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContent count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
    
}

@end

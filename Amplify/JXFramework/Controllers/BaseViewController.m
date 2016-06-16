//
//  BaseViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/1/26.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
    
//    NSArray * hideViewControllerClassArr;
    
    //首页
    NSArray * homeViewArr;
    
    //遮罩
    UIImageView  * maskImageView;
}

@end

@implementation BaseViewController

#pragma -marke life cycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HexRGB(0xffffff)}];
    self.navigationController.navigationBar.barTintColor = HexRGBAlpha(0x252525, 1.0);
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HexRGB(0xffffff)}];
    self.navigationController.navigationBar.barTintColor = HexRGBAlpha(0x252525, 1.0);
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationController.delegate = self;
   
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"headBack"] style:UIBarButtonItemStylePlain target:self action:nil];
//    backButtonItem.title = @"";
    
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    
    UIImage* image = [UIImage imageNamed:@"headBack"];
    [backButtonItem setBackButtonBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [backButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(-600.f, 0) forBarMetrics:UIBarMetricsDefault];
    

    
    self.navigationItem.backBarButtonItem = backButtonItem;
    
    homeViewArr = [NSArray arrayWithObjects:@"LookForHomeViewController",@"PersonalViewController", nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIViewController * currentViewController = [self.navigationController visibleViewController];
    
    BOOL isHomeView = [homeViewArr containsObject:NSStringFromClass([currentViewController class])];
    
    
    if (isHomeView && [UserManager firstInviteWish]) {
        //添加遮罩
        [self addGuideView];
        [UserManager saveFirstInviteWish:NO];
        
        //通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATION_NAME"
                                                            object:nil];
    }
    
    
    //设置滑动回退
    __weak typeof(self) weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
    //判断是否为第一个view
    if (self.navigationController) {
        if ([self.navigationController.viewControllers count] == 1) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }else{
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
        
    }
}

- (void)addGuideView {
    
    NSString *imageName = nil;
    if (DEVICE_IS_IPHONE6Plus) {
        imageName = @"wishmaskBg";
    } else if(DEVICE_IS_IPHONE6){
        imageName = @"wishMash667";
    }else{
        imageName = @"wishMash568";
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    maskImageView = [[UIImageView alloc] initWithImage:image];
    maskImageView.frame = kScreen_Frame;
    maskImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissGuideView)];
    [maskImageView addGestureRecognizer:tap];
    
    [self.view.window addSubview:maskImageView];
    
}

-(void)dismissGuideView{
    
    [maskImageView removeFromSuperview];
}


#pragma mark - BaseViewDelegate
-(void)baseViewClickToController:(NSString *)clickEventName{
    
    //subClass
    
    DLog(@"clickEventName===%@",clickEventName);
}


#pragma mark- UIGestureRecognizerDelegate
//方法一//
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}


@end

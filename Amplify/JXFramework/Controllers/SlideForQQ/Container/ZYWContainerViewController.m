//
//  ZYWContainerViewController.m
//  ZYWQQ
//
//  Created by Devil on 16/2/23.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "ZYWContainerViewController.h"
#import "ZYWSideView.h"
#import "UIView+SHCZExt.h"
#import "HomTabBarController.h"

@interface ZYWContainerViewController ()

//@property(nonatomic,strong)UIView *MV;

@end

@implementation ZYWContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:13/255.0 green:184/255.0 blue:246/255.0 alpha:1];
    
    [self addSubViews];
    
    [self addRecognizer];

}

//添加子视图
-(void)addSubViews{

    //在self.view上创建一个透明的View
    ZYWSideView *mainView=[[ZYWSideView alloc]initWithFrame:CGRectMake(-self.view.frame.size.width*0.25,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    mainView.currentViewController = self;
    
    //设置冰川背景图
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sidebar_bg"]];
    img.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height*0.4);
    
    [self.view addSubview:img];
    
    //添加
    [self.view addSubview:mainView];
    
    [self addTabbarController];
    
}

//添加主控制器（tabbarcontroller）的View

-(void)addTabbarController{

    HomTabBarController *MVC = [[HomTabBarController alloc] init];
    
    //  添加子控制器 - 保证响应者链条的正确传递
    [self addChildViewController:MVC];
    
//    NSLog(@"%@", self.childViewControllers);
    
    //  将 MVC 的视图，添加到 self.view 上
    [self.view addSubview:MVC.view];
    
//    NSLog(@"%@",self.view.subviews);
    MVC.view.frame = self.view.bounds;

}

//添加手势
-(void)addRecognizer{
    //    添加拖拽
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanEvent:)];
    
    [self.view addGestureRecognizer:pan];
}


//实现拖拽
-(void)didPanEvent:(UIPanGestureRecognizer *)recognizer{
    
    
    // 1. 获取手指拖拽的时候, 平移的值
    CGPoint translation = [recognizer translationInView:[self.view.subviews objectAtIndex:2]];
    
    // 2. 让当前控件做响应的平移
    [self.view.subviews objectAtIndex:2].transform = CGAffineTransformTranslate([self.view.subviews objectAtIndex:2].transform, translation.x, 0);
    
    [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
 
    // 3. 每次平移手势识别完毕后, 让平移的值不要累加
    [recognizer setTranslation:CGPointZero inView:[self.view.subviews objectAtIndex:2]];
    
    //获取最右边范围
    CGAffineTransform  rightScopeTransform=CGAffineTransformTranslate(self.view.transform,[UIScreen mainScreen].bounds.size.width*0.75, 0);
    
    //    当移动到右边极限时
    if ([self.view.subviews objectAtIndex:2].transform.tx>rightScopeTransform.tx) {
        
        //        限制最右边的范围
        [self.view.subviews objectAtIndex:2].transform=rightScopeTransform;
        //        限制透明view最右边的范围
        [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
        
        //        当移动到左边极限时
    }else if ([self.view.subviews objectAtIndex:2].transform.tx<0.0){
        
        //        限制最左边的范围
        [self.view.subviews objectAtIndex:2].transform=CGAffineTransformTranslate(self.view.transform,0, 0);
        //    限制透明view最左边的范围
        [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
        
    }
    //    当托拽手势结束时执行
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.2 animations:^{
            
            if ([self.view.subviews objectAtIndex:2].x >[UIScreen mainScreen].bounds.size.width*0.5) {
                
                [self.view.subviews objectAtIndex:2].transform=rightScopeTransform;
                
                [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
                
            }else{
                
                [self.view.subviews objectAtIndex:2].transform = CGAffineTransformIdentity;
                
                [self.view.subviews objectAtIndex:1].ttx=[self.view.subviews objectAtIndex:2].ttx/3;
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

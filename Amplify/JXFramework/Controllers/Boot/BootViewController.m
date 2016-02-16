//
//  BootViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/14.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BootViewController.h"

@interface BootViewController (){
    NSArray * imageArr;
    
    int currentPageIndex;
}

@end

@implementation BootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    imageArr = [[NSArray alloc] initWithObjects:@"Default~iphone.png",@"Default~iphone.png",@"Default~iphone.png",@"Default~iphone.png", nil];
    
    [self initScrollViewFrom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bootBtnClick:(id)sender {
    
    //切换到主页
}



-(void)initScrollViewFrom{
    NSInteger page =0;
    for (NSString* imageStr in imageArr) {
        UIView * bgView =[[UIView alloc] initWithFrame:CGRectMake(page*MAIN_SCREEN_WITH, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT)];
        UIImageView *scrollImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WITH, MAIN_SCREEN_HIGHT)];
        UIImage * scrollImage = [UIImage imageNamed:imageStr];
        scrollImageView.image = scrollImage;
        
        [bgView addSubview:scrollImageView];
        [self.bagScrollView addSubview:bgView];
        page++;
    }
    
    self.bagScrollView.contentSize = CGSizeMake(MAIN_SCREEN_WITH*imageArr.count, MAIN_SCREEN_HIGHT);
    self.bagScrollView.showsHorizontalScrollIndicator = NO;
    self.bagScrollView.showsVerticalScrollIndicator = NO;
    self.bagScrollView.scrollsToTop =NO;
    self.pageControl.numberOfPages = imageArr.count;
    self.pageControl.currentPage =0;
    self.bagScrollView.pagingEnabled = YES;
    
    
    self.startBtn.hidden =YES;
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.bagScrollView.frame.size.width;
    int page = floor((self.bagScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    currentPageIndex=page;
    self.pageControl.currentPage = page;
    
    if(page==imageArr.count-1){
        self.startBtn.hidden = NO;
    }else{
        self.startBtn.hidden =YES;
    }
}
@end

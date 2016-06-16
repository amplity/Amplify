//
//  ScrollMenuViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/4/13.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "ScrollMenuViewController.h"

#import "XHMenu.h"
#import "XHScrollMenu.h"
#import "ScrollTabData.h"


@interface ScrollMenuViewController () <XHScrollMenuDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) XHScrollMenu *scrollMenu;
@property (nonatomic, strong) NSMutableArray *menus;
@property (nonatomic, assign) BOOL shouldObserving;
@end

@implementation ScrollMenuViewController

- (NSMutableArray *)menus {
    if (!_menus) {
        _menus = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _menus;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.shouldObserving = YES;
    
    
    [self.view addSubview:[[UIView alloc] init]];
    
    _scrollMenu = [[XHScrollMenu alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 36)];
    _scrollMenu.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    _scrollMenu.delegate = self;
    //    _scrollMenu.selectedIndex = 3;
    [self.view addSubview:self.scrollMenu];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollMenu.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(_scrollMenu.frame))];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    
    [self.view addSubview:self.scrollView];
    
    int i= 0;
    for (ScrollTabData * scrolltabData in self.inputViewData) {
        XHMenu *menu = [[XHMenu alloc] init];
        
//        NSString *title = nil;
//        switch (i) {
//            case 0:
//                title = @"    头条    ";
//                break;
//            case 1:
//                title = @"  热点新闻  ";
//                break;
//            case 2:
//                title = @"    原创    ";
//                break;
//            case 3:
//                title = @"    汽车    ";
//                break;
//            case 4:
//                title = @"CBA";
//                break;
//            case 5:
//                title = @"NBA";
//                break;
//            case 6:
//                title = @"热点新闻";
//                break;
//            case 8:
//                title = @"房产";
//                break;
//            case 9:
//                title = @"新闻热点";
//                break;
//            default:
//                title = @"热点";
//                break;
//        }
        menu.title = scrolltabData.title;
        
        menu.titleNormalColor = [UIColor colorWithWhite:0.141 alpha:1.000];
        menu.titleFont = [UIFont boldSystemFontOfSize:16];
        [self.menus addObject:menu];
        
        UIWebView * webView = scrolltabData.baseWebView;
        webView.frame = CGRectMake(i * CGRectGetWidth(_scrollView.bounds), 0, CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds));
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.10.54/scout/article/list"]]];
        //        UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        //        logoImageView.frame = CGRectMake(i * CGRectGetWidth(_scrollView.bounds), 0, CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds));
        [_scrollView addSubview:webView];
        i++;
    }
    
    
    [_scrollView setContentSize:CGSizeMake(self.menus.count * CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds))];
    [self startObservingContentOffsetForScrollView:_scrollView];
    
    _scrollMenu.menus = self.menus;
    [_scrollMenu reloadData];
}

- (void)startObservingContentOffsetForScrollView:(UIScrollView *)scrollView
{
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
}

- (void)stopObservingContentOffset
{
    if (self.scrollView) {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
        self.scrollView = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self stopObservingContentOffset];
}

- (void)scrollMenuDidSelected:(XHScrollMenu *)scrollMenu menuIndex:(NSUInteger)selectIndex {
    
    DLog(@"selectIndex : %lu", (unsigned long)selectIndex);
    self.shouldObserving = NO;
    [self menuSelectedIndex:selectIndex];
}

- (void)scrollMenuDidManagerSelected:(XHScrollMenu *)scrollMenu {
    DLog(@"scrollMenuDidManagerSelected");
}

- (void)menuSelectedIndex:(NSUInteger)index {
    CGRect visibleRect = CGRectMake(index * CGRectGetWidth(self.scrollView.bounds), 0, CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.scrollView scrollRectToVisible:visibleRect animated:NO];
    } completion:^(BOOL finished) {
        self.shouldObserving = YES;
    }];
}

#pragma mark - ScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    //根据当前的坐标与页宽计算当前页码
    int currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1;
    [self.scrollMenu setSelectedIndex:currentPage animated:YES calledDelegate:NO];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"] && self.shouldObserving) {
        //每页宽度
        CGFloat pageWidth = self.scrollView.frame.size.width;
        //根据当前的坐标与页宽计算当前页码
        NSUInteger currentPage = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        if (currentPage > self.menus.count - 1)
            currentPage = self.menus.count - 1;
        
        CGFloat oldX = currentPage * CGRectGetWidth(self.scrollView.frame);
        if (oldX != self.scrollView.contentOffset.x) {
            BOOL scrollingTowards = (self.scrollView.contentOffset.x > oldX);
            NSInteger targetIndex = (scrollingTowards) ? currentPage + 1 : currentPage - 1;
            if (targetIndex >= 0 && targetIndex < self.menus.count) {
                CGFloat ratio = (self.scrollView.contentOffset.x - oldX) / CGRectGetWidth(self.scrollView.frame);
                CGRect previousMenuButtonRect = [self.scrollMenu rectForSelectedItemAtIndex:currentPage];
                CGRect nextMenuButtonRect = [self.scrollMenu rectForSelectedItemAtIndex:targetIndex];
                CGFloat previousItemPageIndicatorX = previousMenuButtonRect.origin.x;
                CGFloat nextItemPageIndicatorX = nextMenuButtonRect.origin.x;
                
                /* this bug for Memory
                 UIButton *previosSelectedItem = [self.scrollMenu menuButtonAtIndex:currentPage];
                 UIButton *nextSelectedItem = [self.scrollMenu menuButtonAtIndex:targetIndex];
                 [previosSelectedItem setTitleColor:[UIColor colorWithWhite:0.6 + 0.4 * (1 - fabsf(ratio))
                 alpha:1.] forState:UIControlStateNormal];
                 [nextSelectedItem setTitleColor:[UIColor colorWithWhite:0.6 + 0.4 * fabsf(ratio)
                 alpha:1.] forState:UIControlStateNormal];
                 */
                CGRect indicatorViewFrame = self.scrollMenu.indicatorView.frame;
                
                if (scrollingTowards) {
                    indicatorViewFrame.size.width = CGRectGetWidth(previousMenuButtonRect) + (CGRectGetWidth(nextMenuButtonRect) - CGRectGetWidth(previousMenuButtonRect)) * ratio;
                    indicatorViewFrame.origin.x = previousItemPageIndicatorX + (nextItemPageIndicatorX - previousItemPageIndicatorX) * ratio;
                } else {
                    indicatorViewFrame.size.width = CGRectGetWidth(previousMenuButtonRect) - (CGRectGetWidth(nextMenuButtonRect) - CGRectGetWidth(previousMenuButtonRect)) * ratio;
                    indicatorViewFrame.origin.x = previousItemPageIndicatorX - (nextItemPageIndicatorX - previousItemPageIndicatorX) * ratio;
                }
                
                self.scrollMenu.indicatorView.frame = indicatorViewFrame;
            }
        }
    }
}

@end

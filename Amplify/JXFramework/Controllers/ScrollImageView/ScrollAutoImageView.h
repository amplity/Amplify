//
//  ScrollAutoImageView.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/14.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ScrollAutoImageView;
@protocol ScrollAutoImageViewDelegate <NSObject>

- (void)didClickPage:(ScrollAutoImageView *)view atIndex:(NSInteger)index;

@end


/**
 *  广告位
 */
@interface ScrollAutoImageView : UIView<UIScrollViewDelegate>{
    __unsafe_unretained id <ScrollAutoImageViewDelegate> _delegate;
}



@property (nonatomic, assign) id <ScrollAutoImageViewDelegate> delegate;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray *imageViewAry;

@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly) UIPageControl *pageControl;
@end

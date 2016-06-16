//
//  LZPageViewController.h
//  LZSegmentPageController
//
//  Created by nacker on 16/3/25.
//  Copyright © 2016年 帶頭二哥 QQ:648959. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LZPageViewController : BaseViewController


@property (nonatomic, strong) NSArray *inputViewDatas;

- (instancetype)initWithTitles:(NSArray *)titlesArray controllersClass:(NSArray *)controllersClass inputViewDatas:(NSArray*)inputViewDatas;

@end

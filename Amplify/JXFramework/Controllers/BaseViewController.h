//
//  BaseViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/1/26.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"

@interface BaseViewController : UIViewController<BaseViewDelegate,LoginResultDelegate,UIGestureRecognizerDelegate>


@property (nonatomic, strong) id inputViewData;
@end

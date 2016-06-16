//
//  DiscoverInfoViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/5/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseWebViewController.h"

@interface DiscoverInfoViewController : BaseWebViewController<LoginResultDelegate>

@property (weak, nonatomic) IBOutlet UILabel *shopCardNumLab;

@property (weak, nonatomic) IBOutlet UIView *shopCardNumView;


//关注
@property (weak, nonatomic) IBOutlet UIButton *guanzhuBtn;


//飞入的view
@property (weak, nonatomic) IBOutlet UIView *flyView;

@property (weak, nonatomic) IBOutlet UIView *shopCartBotView;

/**
 *  关注
 */
- (IBAction)guanzhuBtnClick:(id)sender;
//立即购买
-(IBAction)buyShopToBtn:(id)sender;

//加入购物车
-(IBAction)addShoppingCart:(id)sender;


//购物车
- (IBAction)shoppingCartClick:(id)sender;

@end

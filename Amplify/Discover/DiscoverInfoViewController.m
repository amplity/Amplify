//
//  DiscoverInfoViewController.m
//  Amplify
//
//  Created by ZhangJixu on 16/5/3.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "DiscoverInfoViewController.h"
#import "MarketInfoData.h"
#import "ShoppingData.h"
#import "UserManager.h"
#import "BaseWebManager.h"
#import "TipManager.h"
#import "SettlementViewController.h"
#import "LoginViewController.h"
#import "DiscoveryService.h"
#import "ShopCartViewController.h"
#import "LinkModel.h"
#import "LookForShareFrameView.h"
#import "ShareModel.h"


@interface DiscoverInfoViewController (){
    //关注数量
    int guanzhuNum;
    
    MarketInfoData * marketInfoData;
    
    //点击立即购买，化妆包需要的数据
    NSDictionary * clickBuyDic;
    ShoppingData* shoppingData;
    
    LinkModel * linkModel;
    
    ShareModel * shareModel;
    
    //加入购物车的数量
    NSString* shopCartNum;
   
}

@end

@implementation DiscoverInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"商品详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:HexRGB(0xffffff)}];
    
    UIImage *rightImage = [UIImage imageNamed:@"discoverInfoShare"];
    rightImage =[rightImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnClick:)];

    
    
    
//    UIImage *leftImage = [UIImage imageNamed:@"store"];
//    leftImage =[leftImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnLeftClick:)];
//    
//    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    
    
    marketInfoData = [[MarketInfoData alloc] init];
    clickBuyDic = [[NSDictionary alloc] init];
    
    shareModel = [[ShareModel alloc] init];
    
    
    NSString * urlStr = @"";
    linkModel = self.inputViewData;
    if (self.inputViewData) {
        urlStr = linkModel.url;
    }else{
        urlStr = @"";//填入
    }
    
    NSString * comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:urlStr withParameter:nil];
    [self.baseWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:comUrl]]];
    
//    [self.navigationController setHidesBarsOnSwipe:YES];
    
    
    
    //购物车数量
    self.shopCardNumLab.hidden = YES;
    self.shopCardNumView.layer.cornerRadius = 10;
    self.shopCardNumView.hidden = YES;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationController setHidesBarsOnSwipe:NO];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    if( self.view.window == nil && [self isViewLoaded]) {
        
        //安全移除控制器的view;
        
        self.view = nil;
        
    }
}


/*立即购买*/
-(IBAction)buyShopToBtn:(id)sender{
    
    clickBuyDic =(NSDictionary*)[[BaseWebManager shareWebManager] fixJavascriptDataByFun:@"purchaseNow();" withWebView:self.baseWebView];
    //判断个数
    //判断类别
    
    NSString* errStr = nil;
    if([[clickBuyDic objectForKey:@"desc"]isEqualToString:@"outofstock"]){
        errStr = @"没有库存了！";
    }
    if([[clickBuyDic objectForKey:@"desc"]isEqualToString:@"nosku"]){
        errStr = @"请选择类别";
    }
    if([[clickBuyDic objectForKey:@"desc"]isEqualToString:@"nonum"]){
        errStr = @"请选择数量";
    }
    
    if(errStr){
        [TipManager showTipsWithInforStr:errStr withAfter:1.0];
        return;
    }
    
    
    //判断时候登陆
    if(![UserManager isLogin]){
        
        [self goLoginAction:@"immediatelyClick"];
        
        return;
    }
    
    SettlementViewController * settlementViewController = [[SettlementViewController alloc] init];
    
    NSString* settlementVIewUrl = [clickBuyDic objectForKey:@"url"];
    settlementViewController.inputViewData = settlementVIewUrl;
    
    [self.navigationController pushViewController:settlementViewController animated:YES];
    
}


/*加入化妆包*/
-(IBAction)addShoppingCart:(id)sender{
    
    clickBuyDic =(NSDictionary*)[[BaseWebManager shareWebManager] fixJavascriptDataByFun:@"addtrolleyc();" withWebView:self.baseWebView];
    
    
    //判断个数
    //判断类别
    
    NSString* errStr = nil;
    if([[clickBuyDic objectForKey:@"desc"]isEqualToString:@"outofstock"]){
        errStr = @"没有库存了！";
    }
    if([[clickBuyDic objectForKey:@"desc"]isEqualToString:@"nosku"]){
        errStr = @"请选择类别";
    }
    if([[clickBuyDic objectForKey:@"desc"]isEqualToString:@"nonum"]){
        errStr = @"请选择数量";
    }
    
    if(errStr){
        
        [TipManager showTipsWithInforStr:errStr withAfter:1.0];
        return;
    }
    
    //判断时候登陆
    if(![UserManager isLogin]){
        
        [self goLoginAction:@"shopCartClick"];
        
        return;
    }
    
    [self goShopCart];
    
}

- (IBAction)shoppingCartClick:(id)sender {
    
    //购物车
    
    
    //判断时候登陆
    if(![UserManager isLogin]){
        
        [self goLoginAction:@""];
        
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary *shopCartDic = (NSDictionary*)[[BaseWebManager shareWebManager] fixJavascriptDataByFun:@"getBag();" withWebView:self.baseWebView];
        NSString *shopCartUrl = [shopCartDic objectForKey:@"url"];
        
        NSString* comUrl = [[BaseWebManager shareWebManager] getCombineUrlByParameter:shopCartUrl withParameter:[NSDictionary dictionaryWithObject:[UserManager token] forKey:@"token"]];
        ShopCartViewController * shopCartViewController = [[ShopCartViewController alloc] init];
        shopCartViewController.inputViewData = comUrl;
        [weakSelf.navigationController pushViewController:shopCartViewController animated:YES];
        
        
        
    });
}

//跳转到购物车
-(void)goShopCart{
    NSString* productId = [clickBuyDic objectForKey:@"productId"];
    NSString* skuId = [clickBuyDic objectForKey:@"skuId"];
    NSString* num = [clickBuyDic objectForKey:@"num"];
    
    
    __weak typeof(self) weakSelf = self;
    
    [DiscoveryService addShopGetUrl:productId withSkuId:skuId withNum:num withHandler:^(id responseObj) {
        shoppingData = [ShoppingData mj_objectWithKeyValues:responseObj];
        
        
        if([shoppingData.responseHead.code isEqualToString:@"00000"]){
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //增加购物车中的数量
                
                
                shopCartNum = shoppingData.responseBody.totalNum;
//                [self addAnimatedWithFrame:self.flyView.frame];
                [self refreshShopCardNum:shopCartNum];
                
            });
            
        }else{
            
        }
        
    } withHandler:^(NSError *error) {
        
    }];
}


-(void)goLoginAction:(NSString*)clickStr{
    dispatch_async(dispatch_get_main_queue(), ^{
        LoginViewController * loginViewController = [LoginViewController alloc];
        loginViewController.loginRestltDelegate = self;
        loginViewController.beforeOptionStr = clickStr;
        [self.navigationController pushViewController:loginViewController animated:YES];
    });
}


//- (IBAction)shareBtnLeftClick:(id)sender {
//    
//    
//    
//    
//    DLog(@"topViewController ===%@",[self.navigationController.topViewController class]);
//    
//    DLog(@"visibleViewController ===%@",[self.navigationController.visibleViewController class]);
//    
//    DLog(@"viewControllers count ===%d",[self.navigationController.viewControllers count]);
//    
//    UINavigationController *nav = self.navigationController;
//    
//    UIViewController * viewContr = [self.navigationController popViewControllerAnimated:YES];
//    
//    
//    DLog(@"viewContr ===%@",[viewContr class]);
//}

//分享
- (IBAction)shareBtnClick:(id)sender {
    if(![UserManager isLogin]){
        
        
        
        return;
    }
    
    
    if ([UserManager isLogin]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            LookForShareFrameView * lookForShareFrameView = [LookForShareFrameView instancesViewWithBaseModel:shareModel];
            lookForShareFrameView.baseViewDelegate = self;
            [self.view.window addSubview:lookForShareFrameView];
            
        });
    }else{
        
        [self goLoginAction:@""];
        
        
    }
}




- (IBAction)guanzhuBtnClick:(id)sender {
    if(![UserManager isLogin]){
        
        [self goLoginAction:@""];
        
        return;
    }
    
    
    marketInfoData.state = !marketInfoData.state;
    [self initLoadDataForServices];
    
}

//设置关注按钮
-(void) guanzhuBtnStyle{
    self.guanzhuBtn.selected = marketInfoData.state;//设置关注，改变关注图片
}

//向后台加载数据
-(void)initLoadDataForServices{
    NSDictionary* jsReturnData=(NSDictionary*)[[BaseWebManager shareWebManager] fixJavascriptDataByFun:@"getlikeparams();" withWebView:self.baseWebView];
    [DiscoveryService likeGood:[jsReturnData objectForKey:@"productId"] withState:marketInfoData.state withHandler:^(id responseObj) {
        NSDictionary * responseHead = [responseObj objectForKey:@"responseHead"];
        if([[responseHead objectForKey:@"code"] isEqualToString:@"00000"]){
            NSDictionary * marketInfoDataDic = [responseObj objectForKey:@"responseBody"];
            
            NSString * stateStr = [marketInfoDataDic objectForKey:@"state"];
            marketInfoData.state = [stateStr isEqualToString:@"1"] ? YES:NO;
            marketInfoData.guanzhuNum = [marketInfoDataDic objectForKey:@"num"];
            
            [self guanzhuBtnStyle];
        }else{
            [TipManager showTipsWithInforStr:[responseHead objectForKey:@"error"] withAfter:1.0];
        }
        
    } withHandler:^(NSError *error) {
        
    }];
}


//刷新
-(void)onGoDownRefreshWeb:(void (^)())refreshDownCompleted{
    refreshDownCompleted();
    
    [self.baseWebView baseLoadRequest:self.refrshUrl];
}

//设置购物车数量
-(void)refreshShopCardNum:(NSString*)numstr{
    
    self.shopCardNumLab.text = numstr;
    
    
    self.shopCardNumLab.hidden = numstr.intValue>0 ?NO : YES;
    self.shopCardNumView.hidden = numstr.intValue>0 ?NO : YES;
}


#pragma mark - 添加到购物车的动画效果
// huangyibiao
- (void)addAnimatedWithFrame:(CGRect)frame {
    // 该部分动画 以self.view为参考系进行
    frame = [[UIApplication sharedApplication].keyWindow  convertRect:frame fromView:self.shopCartBotView];
    UIButton *move = [[UIButton alloc] initWithFrame:frame];
    [move setBackgroundColor:HexRGB(0xFFA215)];
//    [move setTitle:self.RFcell.headBtn.currentTitle forState:UIControlStateNormal];
    [move setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    move.contentMode = UIViewContentModeScaleToFill;
    [[UIApplication sharedApplication].keyWindow addSubview:move];
    
    
    
//    move.alpha = 1.0f;
//    CGRect imageFrame = move.frame;
//    //frame.origin，动画开始的地方
//    CGPoint viewOrigin = move.frame.origin;
//    viewOrigin.y = viewOrigin.y + imageFrame.size.height / 2.0f;
//    viewOrigin.x = viewOrigin.x + imageFrame.size.width / 2.0f;
//    
//    move.frame = imageFrame;
//    move.layer.position = viewOrigin;
////    [self.view addSubview:move];
//    
//    // 淡出效果
//    CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    [fadeOutAnimation setToValue:[NSNumber numberWithFloat:0.3]];
//    fadeOutAnimation.fillMode = kCAFillModeForwards;
//    fadeOutAnimation.removedOnCompletion = NO;
//    
//    //设置缩放
//    CABasicAnimation *resizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
//    [resizeAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(40.0f, imageFrame.size.height * (40.0f / imageFrame.size.width))]];
//    resizeAnimation.fillMode = kCAFillModeForwards;
//    resizeAnimation.removedOnCompletion = NO;
//    
//    // 设置路径运动
//    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    pathAnimation.calculationMode = kCAAnimationPaced;
//    pathAnimation.fillMode = kCAFillModeForwards;
//    pathAnimation.removedOnCompletion = NO;
//    //设置动画结束点
//    CGPoint endPoint = CGPointMake(self.shopCardNumLab.frame.origin.x,MAIN_SCREEN_HIGHT-CGRectGetMaxY(self.shopCartBotView.bounds));
//    //在最后一个选项卡结束动画
//    //CGPoint endPoint = CGPointMake( 320-40.0f, 480.0f);
//    CGMutablePathRef curvedPath = CGPathCreateMutable();
//    CGPathMoveToPoint(curvedPath, NULL, viewOrigin.x, viewOrigin.y);
//    CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, viewOrigin.y, endPoint.x, viewOrigin.y, endPoint.x, endPoint.y);
//    pathAnimation.path = curvedPath;
//    CGPathRelease(curvedPath);
//    
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.fillMode = kCAFillModeForwards;
//    group.removedOnCompletion = NO;
//    [group setAnimations:[NSArray arrayWithObjects:fadeOutAnimation, pathAnimation, resizeAnimation, nil]];
//    group.duration = 0.7f;
//    group.delegate = self;
//    [group setValue:move forKey:@"imageViewBeingAnimated"];
//    
//    [move.layer addAnimation:group forKey:@"savingAnimation"];
    
    
    
    // 加入购物车动画效果
    [UIView animateWithDuration:1.2 animations:^{
        
        //第一个移动点
        move.frame = CGRectMake(self.shopCardNumLab.frame.origin.x+100,MAIN_SCREEN_HIGHT-CGRectGetMaxY(self.shopCartBotView.bounds)-200,frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        
        
        //第二个移动点
        [UIView animateWithDuration:1.0 animations:^{
            move.frame = CGRectMake(self.shopCardNumLab.frame.origin.x,MAIN_SCREEN_HIGHT-CGRectGetMaxY(self.shopCartBotView.bounds),frame.size.width, frame.size.height);
        } completion:^(BOOL finished) {
            
            
            [move removeFromSuperview];
            
            [self refreshShopCardNum:shopCartNum];
            
        }];  

        
    }];  
    
    return;
    
    
}



#pragma mark - LoginResultDelegate
-(void)showLoginResult:(BOOL)isSuccess withClickStr:(NSString*)clickStr{
    
    //区分，点击来源
    if (isSuccess) {
        
        if ([clickStr isEqualToString:@"shopCartClick"]) {
            [self goShopCart];
        }else if([clickStr isEqualToString:@"immediatelyClick"]){
            [self buyShopToBtn:nil];
        }
        
    }else{
        
//        NSArray * views = self.navigationController.viewControllers;
//        
//        if ([self.navigationController.topViewController isKindOfClass:NSClassFromString(@"LoginMainViewController")]) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//        
//         NSArray * views1 = self.navigationController.viewControllers;
//        
//        DLog(@"fff");
    }
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
    [[BaseWebControllerManager shareWebManager] pushControllerForJsObject:self withBaseWebView:webView];
    
    NSDictionary* jsReturnData=(NSDictionary*)[[BaseWebManager shareWebManager] fixJavascriptDataByFun:@"getlikeparams()" withWebView:webView];
    
    
    marketInfoData.state = [[jsReturnData objectForKey:@"state"] isEqualToString:@"1"] ? YES:NO;
    [self guanzhuBtnStyle];
    
    
    NSDictionary* shopCardNumDic=(NSDictionary*)[[BaseWebManager shareWebManager] fixJavascriptDataByFun:@"getTrolleyNum()" withWebView:webView];
    //购物车数量
    shopCartNum = [shopCardNumDic objectForKey:@"trolleyNum"];
    [self refreshShopCardNum:shopCartNum];
}



@end


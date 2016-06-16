//
//  BaseView.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

/**
 *  baseview 点击传递给controller
 */
@protocol BaseViewDelegate <NSObject>

-(void)baseViewClickToController:(NSString*)clickEventName withObject:(id)object;

@end

@interface BaseView : UIView

@property (nonatomic, strong) id<BaseViewDelegate> baseViewDelegate;

@property(strong,nonatomic) BaseModel * baseViewModel;

+(instancetype)instancesView;


/**
 *  设置baseView入口
 *
 *  @param baseModel 数据源
 *
 *  @return 
 */
+(instancetype) instancesViewWithBaseModel:(BaseModel *)baseModel;


/**
 *  设置BaseView 样式
 */
-(void)initBaseView:(BaseView*)baseView;


/**
 *  点击传人点击参数
 *
 *  @param clickEventName 点击参数，自定义。
 */
-(void)baseViewClickToController:(NSString*)clickEventName withObject:(id)object;

@end

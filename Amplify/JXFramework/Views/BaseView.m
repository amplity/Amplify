//
//  BaseView.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

-(void)setBaseViewModel:(BaseModel *) baseViewModel
{
    _baseViewModel=baseViewModel;
    
}

+(instancetype) instancesView{
    
    NSBundle *bundle=[NSBundle mainBundle];
    NSArray *objs=[bundle loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [objs lastObject];
    
}

+(instancetype) instancesViewWithBaseModel:(BaseModel *)baseViewModel{
    BaseView *baseView=[self instancesView];
    baseView.baseViewModel=baseViewModel;
    [baseView initBaseView:baseView];
    return baseView;
}

-(void)initBaseView:(BaseView*)baseView{
    //subClass
}

-(void)baseViewClickToController:(NSString *)clickEventName withObject:(id)object;{
    
    [self.baseViewDelegate baseViewClickToController:clickEventName withObject:object];
}

@end

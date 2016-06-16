//
//  HelpTableViewCell.m
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/3.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "HelpTableViewCell.h"
#import "HelpObject.h"


@interface HelpTableViewCell (){
    HelpObject * helpObject;
}

@end

@implementation HelpTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)nextBtnClick:(id)sender {
    
    [self baseTableCellClick:@"HelpTableViewCell" withObjec:helpObject];
    
}


-(void)setCellData:(id)obj{
    helpObject = (HelpObject*)obj;
    
    self.nameLab.text = helpObject.titileNameStr;
}

@end

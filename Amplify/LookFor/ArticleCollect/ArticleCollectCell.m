//
//  ArticleCollectCell.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "ArticleCollectCell.h"
#import "KCContact.h"

@implementation ArticleCollectCell

-(void)initSubView{
    
}

-(void)setCellData:(id)obj{
    KCContact * contact = obj;
    
    self.brandLab.text = [contact getName];
    self.infoTxt.text =contact.phoneNumber;
//    [self.selectImageBtn setTitle:@"是的" forState:UIControlStateNormal];
    
    self.height = 80;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self.selectImageBtn setTitle:@"是的" forState:UIControlStateNormal];
    }else{
        [self.selectImageBtn setTitle:@"点击" forState:UIControlStateNormal];
    }
    
}



@end

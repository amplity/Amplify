//
//  BaseTableCell.m
//  Amplify
//
//  Created by ZhangJixu on 16/2/16.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseTableCell.h"

@implementation BaseTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)initSubView{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

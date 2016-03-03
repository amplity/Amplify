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
        return [self loadCellNib];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}


-(id)initWithFrame:(CGRect)frame{
    
    
    
    return [self loadCellNib];
    
}

-(void)initSubView{
    
}

-(BaseTableCell*)loadCellNib{
    BaseTableCell * baseTableCell;
    // 初始化时加载baseTabelViewCell.xib文件
    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    
    // 如果路径不存在，return nil
    if (arrayOfViews.count < 1)
    {
        return nil;
    }
    // 如果xib中view不属于UITableViewCell类，return nil
    if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UITableViewCell class]])
    {
        return nil;
    }
    // 加载nib
    baseTableCell = [arrayOfViews objectAtIndex:0];
    
    return baseTableCell;
}


-(void)setCellData:(id)obj{
    //subClass
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  BaseTableCell.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/16.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableCell : UITableViewCell


#pragma mark 单元格高度
@property (assign,nonatomic) CGFloat height;


/**
 *  设置cell 状态数据
 *
 *  @param obj
 */
-(void)setCellData:(id)obj;
@end

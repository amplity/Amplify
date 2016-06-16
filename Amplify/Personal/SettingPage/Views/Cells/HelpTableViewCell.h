//
//  HelpTableViewCell.h
//  HarmayLXApp
//
//  Created by ZhangJixu on 15/12/3.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "BaseTableCell.h"

@interface HelpTableViewCell : BaseTableCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
- (IBAction)nextBtnClick:(id)sender;

@end

//
//  ArticleCollectCell.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseTableCell.h"

@interface ArticleCollectCell : BaseTableCell
@property (weak, nonatomic) IBOutlet UIImageView *hearImage;

@property (weak, nonatomic) IBOutlet UILabel *brandLab;
@property (weak, nonatomic) IBOutlet UITextView *infoTxt;
@property (weak, nonatomic) IBOutlet UIButton *selectImageBtn;

@end

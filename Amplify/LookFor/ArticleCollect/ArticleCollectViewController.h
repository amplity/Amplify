//
//  ArticleCollectViewController.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/29.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseMultipleSectionTableViewController.h"


/**
 *  文章收藏
 */
@interface ArticleCollectViewController : BaseMultipleSectionTableViewController
@property (weak, nonatomic) IBOutlet UIView *deleteView;

- (IBAction)deleteBtnClick:(id)sender;

@end

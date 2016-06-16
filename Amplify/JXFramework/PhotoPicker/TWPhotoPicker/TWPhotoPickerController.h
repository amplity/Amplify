//
//  TWPhotoPickerController.h
//  InstagramPhotoPicker
//
//  Created by Emar on 12/4/14.
//  Copyright (c) 2014 wenzhaot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface TWPhotoPickerController : BaseViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,BaseViewDelegate>

//@property (nonatomic, strong) id inputViewData;

@property (nonatomic, copy) void(^cropBlock)(UIImage *image);


@property(nonatomic,strong)UIButton *downButton;
@property(nonatomic,strong)NSMutableArray *titleNameArray;

@end

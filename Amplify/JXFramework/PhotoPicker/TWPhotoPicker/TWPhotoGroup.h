//
//  TWPhotoGroup.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/17.
//  Copyright © 2016年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWPhotoGroup : NSObject


@property (nonatomic, strong) NSString *groupName;

@property (nonatomic, strong) NSMutableArray *twPhotoArray;

@property (nonatomic) NSInteger groundIndx;

@end

//
//  PhotoModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/5/25.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

@interface PhotoModel : BaseModel


@property (nonatomic, strong) NSMutableArray *titleNames;


@property (nonatomic, strong) NSMutableArray *nums;


@property (nonatomic, copy) NSMutableArray *images;

@end

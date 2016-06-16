//
//  TWPhotoGroup.m
//  Amplify
//
//  Created by ZhangJixu on 16/3/17.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "TWPhotoGroup.h"


@implementation TWPhotoGroup

-(NSMutableArray*)twPhotoArray{
    if (!_twPhotoArray) {
        _twPhotoArray = [NSMutableArray array];
    }
    return _twPhotoArray;
}

@end

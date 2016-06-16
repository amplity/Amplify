//
//  HomeModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/2/4.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"


@class HomeBody;
@interface HomeModel : BaseModel

@property (nonatomic) HomeBody * responseBody;


@end

@class MakeUptheme;
@interface HomeBody : ResponseBody

@property (nonatomic, assign) NSInteger totalPages;

@property (nonatomic, copy) NSMutableArray *makeUpthemeLists;

@end


@interface MakeUptheme : NSObject
@property (nonatomic, copy) NSString *themeUrl;

@property (nonatomic, copy) NSString *themeTitle;

@property (nonatomic, assign) NSInteger likesCount;

@end















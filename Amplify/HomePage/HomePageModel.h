//
//  HomePageModel.h
//  Amplify
//
//  Created by ZhangJixu on 16/3/23.
//  Copyright © 2016年 hm. All rights reserved.
//

#import "BaseModel.h"

@class HomePageBody;
@interface HomePageModel : BaseModel

@property (nonatomic) HomePageBody *responseBody;

@end


@class HomepageUrlData;
@interface HomePageBody : ResponseBody
@property (nonatomic, copy) NSMutableArray *urlList;


@end


@interface HomepageUrlData : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *url;

@end

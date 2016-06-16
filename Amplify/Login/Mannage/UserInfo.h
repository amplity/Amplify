//
//  UserInfo.h
//  Brand
//
//  Created by Woody Yan on 5/27/14.
//  Copyright (c) 2014 Faker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject  <NSCoding>

@property (nonatomic,copy,readonly) NSString *uid, *displayName, *profileURL, *phoneNum, *sinaID, *wxID;

- (id)initWithUid:(NSString*)uid
      displayName:(NSString*)displayName
       profileURL:(NSString*)profileURL
         phoneNum:(NSString*)phoneNum
           sinaID:(NSString*)sinaID
             wxID:(NSString*)wxID;

@end

//
//  UserInfo.m
//  Brand
//
//  Created by Woody Yan on 5/27/14.
//  Copyright (c) 2014 Faker. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo

-(id)initWithUid:(NSString *)uid displayName:(NSString *)displayName profileURL:(NSString *)profileURL phoneNum:(NSString *)phoneNum sinaID:(NSString *)sinaID wxID:(NSString *)wxID{
    self = [super init];
    if (self)
    {
        _uid = uid;
        _displayName = displayName;
        _profileURL = profileURL;
        _phoneNum = phoneNum;
        _sinaID = sinaID;
        _wxID = wxID;
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.phoneNum forKey:@"phoneNum"];
    [aCoder encodeObject:self.displayName forKey:@"displayName"];
    [aCoder encodeObject:self.profileURL forKey:@"profileURL"];
    [aCoder encodeObject:self.sinaID forKey:@"sinaID"];
    [aCoder encodeObject:self.wxID forKey:@"wxID"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _phoneNum = [aDecoder decodeObjectForKey:@"phoneNum"];
        _displayName = [aDecoder decodeObjectForKey:@"displayName"];
        _profileURL = [aDecoder decodeObjectForKey:@"profileURL"];
        _sinaID = [aDecoder decodeObjectForKey:@"sinaID"];
        _wxID = [aDecoder decodeObjectForKey:@"wxID"];

    }
    return self;
}


@end

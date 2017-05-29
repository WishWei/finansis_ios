//
//  User.m
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import "User.h"

static NSString * const kUserId = @"id";
static NSString * const kUserName = @"name";
static NSString * const kUserPassword = @"password";
static NSString * const kUserSex = @"sex";
static NSString * const kUserLastLogin = @"lastLogin";
static NSString * const kUserStatus = @"status";
static NSString * const kUserCreateTime = @"createTime";

@implementation User
+ (NSDictionary *)replacedKeyFromPropertyName{
    // 模型的desc属性对应着字典中的description
    return @{@"ID" : @"id"};
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.ID forKey:kUserId];
    [aCoder encodeObject:self.name forKey:kUserName];
    [aCoder encodeObject:self.password forKey:kUserPassword];
    [aCoder encodeObject:self.sex forKey:kUserSex];
    [aCoder encodeObject:self.lastLogin forKey:kUserLastLogin];
    [aCoder encodeObject:self.status forKey:kUserStatus];
    [aCoder encodeObject:self.createTime forKey:kUserCreateTime];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super init]){
        self.ID = [aDecoder decodeObjectForKey:kUserId];
        self.name = [aDecoder decodeObjectForKey:kUserName];
        self.password = [aDecoder decodeObjectForKey:kUserPassword];
        self.sex = [aDecoder decodeObjectForKey:kUserSex];
        self.lastLogin = [aDecoder decodeObjectForKey:kUserLastLogin];
        self.status = [aDecoder decodeObjectForKey:kUserStatus];
        self.createTime = [aDecoder decodeObjectForKey:kUserCreateTime];
    }
    return self;
}
@end

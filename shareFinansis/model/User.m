//
//  User.m
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import "User.h"

@implementation User
+ (NSDictionary *)replacedKeyFromPropertyName{
    // 模型的desc属性对应着字典中的description
    return @{@"ID" : @"id"};
}
@end

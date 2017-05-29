//
//  Global.h
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface Global : NSObject
+ (instancetype)shareInstance;

@property(nonatomic,strong) User *loginUser;
@end

//
//  Global.h
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Global : NSObject
+ (instancetype)shareInstance;
- (void)saveLoginUser:(User*)user;
//上次登录过的用户
- (User*)lastLoginUser;

- (void)clearLoginUser;

@end

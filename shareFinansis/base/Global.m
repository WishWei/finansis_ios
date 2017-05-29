//
//  Global.m
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import "Global.h"
#import "NetWorkManager.h"

@interface Global()
@property(nonatomic,strong) User *loginUser;
@end

@implementation Global
+ (instancetype)shareInstance{
    static Global *instance  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{instance = [[Global alloc]init];});
    return instance;
}

- (void)saveLoginUser:(User*)user {
    _loginUser = user;
    [[NetWorkManager shareInstance] saveLoginUserId:user.ID];
}

- (void)clearLoginUser{
    _loginUser = nil;
    [[NetWorkManager shareInstance] clearLoginUserId];
}

@end

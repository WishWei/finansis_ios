//
//  Global.m
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import "Global.h"
#import "NetWorkManager.h"
#import "Type.h"

@interface Global()
@property(nonatomic,strong) User *loginUser;
@property(nonatomic,strong) NSString *userStorePath;
@end

@implementation Global
+ (instancetype)shareInstance{
    static Global *instance  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{instance = [[Global alloc]init];});
    return instance;
}

- (instancetype)init {
    if(self = [super init]) {
         self.userStorePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/adimage"];
    }
    return self;
}

- (void)loadTypes{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"type" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];  //读取数据
    NSMutableArray *types = [NSMutableArray array];
    NSMutableDictionary *categorieImgMap = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in array) {
        Type *type=[[Type alloc] init];
        type.id_=[dict objectForKey:@"id"];
        type.enName=[dict objectForKey:@"enName"];
        type.cnName=[dict objectForKey:@"cnName"];
        type.img=[dict objectForKey:@"img"];
        [types addObject:type];
        [categorieImgMap setObject:type.img forKey:type.cnName];
    }
    self.categorieImgMap = categorieImgMap;
    self.categories=types;
}

- (void)saveLoginUser:(User*)user {
    _loginUser = user;
    [NSKeyedArchiver archiveRootObject:user toFile:self.userStorePath];
    [[NetWorkManager shareInstance] saveLoginUserId:user.ID];
}

- (User*)lastLoginUser {
    User *user=[NSKeyedUnarchiver unarchiveObjectWithFile:self.userStorePath];
    return user;
}

- (void)clearLoginUser{
    _loginUser = nil;
    [[NetWorkManager shareInstance] clearLoginUserId];
}

@end

//
//  NetWorkManager.m
//  zhihuDaily
//
//  Created by 魏希 on 16/3/17.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import "NetWorkManager.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "ResponseBean.h"

@interface NetWorkManager()
@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;
@end
@implementation NetWorkManager

+ (instancetype)shareInstance{
    static NetWorkManager *instance  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{instance = [[NetWorkManager alloc]init];});
    return instance;
}

- (instancetype)init{
    if(self=[super init]){
        self.sessionManager=[AFHTTPSessionManager manager];
        self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.sessionManager.requestSerializer.timeoutInterval = 15.0;
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.sessionManager.completionQueue = dispatch_queue_create("com.wish.netCompletionQueue", DISPATCH_QUEUE_SERIAL);
        User *user = [[Global shareInstance] lastLoginUser];
        if(user) {
            [self saveLoginUserId:user.ID];
        }
    }
    return self;
}

- (void)saveLoginUserId:(NSString *)loginUserId {
    [self.sessionManager.requestSerializer setValue:loginUserId forHTTPHeaderField:@"loginUserId"];
}

- (void)clearLoginUserId {
    [self.sessionManager.requestSerializer setValue:nil forHTTPHeaderField:@"loginUserId"];
}



- (void)request:(NSString*)urlString withParams:(NSDictionary *)params withMethod:(RequestMethod) method withBlock:(NetworkBlock)block{
    if(method == RequestMethodGET){
        [self.sessionManager GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(nil,error);
        }];
    }else if(method == RequestMethodPOST){
        [self.sessionManager POST:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject,nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(nil,error);
        }];
    }

}

- (void)loginWithName:(NSString*)name withPassword:(NSString*) password withBlock:(NetworkBlock)block {
    NSString *fullPath = [NSString stringWithFormat:kNetwrok_Url_Base, @"user/login.do"];
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    [params setValue:name forKey:@"name"];
    [params setValue:password forKey:@"password"];
    [self request:fullPath withParams:params withMethod:RequestMethodGET withBlock:^(id data, NSError *error) {
        if(error){
            error = [NSError errorWithDomain:@"网络异常" code:-9999 userInfo:nil];
            block(nil,error);
        }else{
            ResponseBean *responseBean=[ResponseBean mj_objectWithKeyValues:data];
            block(responseBean,nil);
        }
    }];
}

- (void)accountBooksWithPage:(int) page withPageSize:(int) pageSize withBlock:(NetworkBlock)block {
    NSString *fullPath = [NSString stringWithFormat:kNetwrok_Url_Base, @"accountBook/findAccountBookByUserIdPage.do"];
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    [params setValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [params setValue:[NSString stringWithFormat:@"%d",pageSize] forKey:@"pageSize"];
    [self request:fullPath withParams:params withMethod:RequestMethodGET withBlock:^(id data, NSError *error) {
        if(error){
            error = [NSError errorWithDomain:@"网络异常" code:-9999 userInfo:nil];
            block(nil,error);
        }else{
            ResponseBean *responseBean=[ResponseBean mj_objectWithKeyValues:data];
            block(responseBean,nil);
        }
    }];
}

- (void)accountDetailsWithBookId:(NSString*)bookId withPage:(int) page withPageSize:(int) pageSize withBlock:(NetworkBlock)block {
    NSString *fullPath = [NSString stringWithFormat:kNetwrok_Url_Base, @"accountDetail/findBookDetailByBookIdPage.do"];
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    [params setValue:bookId forKey:@"bookId"];
    [params setValue:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [params setValue:[NSString stringWithFormat:@"%d",pageSize] forKey:@"pageSize"];
    [self request:fullPath withParams:params withMethod:RequestMethodGET withBlock:^(id data, NSError *error) {
        if(error){
            error = [NSError errorWithDomain:@"网络异常" code:-9999 userInfo:nil];
            block(nil,error);
        }else{
            ResponseBean *responseBean=[ResponseBean mj_objectWithKeyValues:data];
            block(responseBean,nil);
        }
    }];
}





@end

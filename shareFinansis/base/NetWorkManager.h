//
//  NetWorkManager.h
//  zhihuDaily
//
//  Created by 魏希 on 16/3/17.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetDefine.h"

#define kNetwrok_Url_Base @"http://sharefinansis.applinzi.com/%@"
//#define kNetwrok_Url_Base @"http://localhost:8080/%@"

@interface NetWorkManager : NSObject
+ (instancetype)shareInstance;
- (void)request:(NSString*)urlString withParams:(NSDictionary *)params withMethod:(RequestMethod) method withBlock:(NetworkBlock)block;

//保存登录用户id到header
- (void)saveLoginUserId:(NSString *)loginUserId;

//删除header中的登录用户id
- (void)clearLoginUserId;

//登录
- (void)loginWithName:(NSString*)name withPassword:(NSString*) password withBlock:(NetworkBlock)block;

//根据用户id分页查询关联的账本
- (void)accountBooksWithPage:(int) page withPageSize:(int) pageSize withBlock:(NetworkBlock)block;

//根据账本id分页查询明细
- (void)accountDetailsWithBookId:(NSString*)bookId withPage:(int) page withPageSize:(int) pageSize withBlock:(NetworkBlock)block;

//查询账本总金额
- (void)accountTotalMoneyWithBookId:(NSString*)bookId
                          withBlock:(NetworkBlock)block;

//保存账本明细
- (void)saveAccountDetailsWithBookId:(NSString*)bookId
                            withType:(int) type
                           withMoney:(double) money
                     withAccountTime:(NSString *) accountTime
                        withCategory:(NSString *) category
                          withRemark:(NSString *) remark
                           withBlock:(NetworkBlock)block;

@end

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

@interface NetWorkManager : NSObject
+ (instancetype)shareInstance;
- (void)request:(NSString*)urlString withParams:(NSDictionary *)params withMethod:(RequestMethod) method withBlock:(NetworkBlock)block;


//登录
- (void)loginWithName:(NSString*)name withPassword:(NSString*) password withBlock:(NetworkBlock)block;

@end

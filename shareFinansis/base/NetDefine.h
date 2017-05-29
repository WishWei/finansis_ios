//
//  NetDefine.h
//  zhihuDaily
//
//  Created by 魏希 on 16/3/17.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethod) {
    RequestMethodGET = 0,
    RequestMethodPOST = 1
};

typedef void(^NetworkBlock)(id data, NSError *error);

@interface NetDefine : NSObject

@end

//
//  ResponseBean.h
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResponseBean : NSObject
//code
@property(nonatomic,strong) NSString *code;
//内容
@property(nonatomic,strong) NSDictionary *content;
//消息
@property(nonatomic,strong) NSString *message;
@end

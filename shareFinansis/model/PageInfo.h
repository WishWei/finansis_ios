//
//  PageInfo.h
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageInfo : NSObject
//内容
@property(nonatomic,strong) NSArray *items;
//页
@property(nonatomic,assign) int page;
//每页条数
@property(nonatomic,assign) int pageSize;
//总数量
@property(nonatomic,assign) int totalCount;
//总页数
@property(nonatomic,assign) int totalPage;
@end

//
//  AccountBook.h
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountBook : NSObject
//id
@property(nonatomic,strong) NSString *ID;
//名称
@property(nonatomic,strong) NSString *name;
//描述
@property(nonatomic,strong) NSString *description_;
//封面图片
@property(nonatomic,strong) NSString *headImg;
//创建人
@property(nonatomic,strong) NSString *createBy;
//状态 0删除 1正常
@property(nonatomic,strong) NSString *status;
//创建时间
@property(nonatomic,strong) NSString *createTime;
@end

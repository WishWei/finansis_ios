//
//  AccountDetail.h
//  shareFinansis
//
//  Created by 魏希 on 2017/5/30.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountDetail : NSObject
//id
@property(nonatomic,strong) NSString *ID;
//账本id
@property(nonatomic,strong) NSString *bookId;
//用户id
@property(nonatomic,strong) NSString *userId;
//1支出 2充值到账本
@property(nonatomic,strong) NSString *type;
//金额
@property(nonatomic,assign) double money;
//交易时间
@property(nonatomic,strong) NSString *accountTime;
//类别
@property(nonatomic,strong) NSString *category;
//备注
@property(nonatomic,strong) NSString *remark;
//状态 0删除 1正常
@property(nonatomic,strong) NSString *status;
//创建时间
@property(nonatomic,strong) NSString *createTime;
//更新时间
@property(nonatomic,strong) NSString *updateTime;
@end

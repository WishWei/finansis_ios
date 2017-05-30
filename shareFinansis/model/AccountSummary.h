//
//  AccountSummary.h
//  shareFinansis
//
//  Created by 魏希 on 2017/5/30.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountSummary : NSObject
//总金额
@property(nonatomic,assign) double totalMoney;
//明细数量
@property(nonatomic,assign) int detailCount;
@end

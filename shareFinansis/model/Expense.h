//
//  Expense.h
//  finanssis
//
//  Created by 魏希 on 16/7/27.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIColor;

@interface Expense : NSObject
@property(nonatomic,assign) int id_;
@property(nonatomic,assign) double money;
@property(nonatomic,strong) NSString *typeId;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *expenseDate;
//type
@property(nonatomic,strong) NSString *enName;
@property(nonatomic,strong) NSString *cnName;
@property(nonatomic,strong) NSString *typeImg;

@property(nonatomic,strong) UIColor *bgColor;
@end

@interface DateExpense : NSObject
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSMutableArray *expenses;

+ (NSArray*)dateExpensesWithExpenses:(NSArray*) expenses;
@end


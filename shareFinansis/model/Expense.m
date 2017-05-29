//
//  Expense.m
//  finanssis
//
//  Created by 魏希 on 16/7/27.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import "Expense.h"

@implementation Expense

@end

@implementation DateExpense
+ (NSArray*)dateExpensesWithExpenses:(NSArray*) expenses{
    if(!expenses||expenses.count==0){
        return nil;
    }
    NSMutableArray *results=[NSMutableArray array];
    for (Expense *expense in expenses) {
        DateExpense *de;
        for (DateExpense *dateExpense in results) {
            if([dateExpense.date isEqualToString:expense.expenseDate]){
                de=dateExpense;
                break;
            }
        }
        if(de){
            [de.expenses addObject:expense];
        }else{
            de=[[DateExpense alloc] init];
            de.date=expense.expenseDate;
            de.expenses=[NSMutableArray array];
            [de.expenses addObject:expense];
            [results addObject:de];
        }
    }
    return results;
}

@end

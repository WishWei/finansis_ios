//
//  ExpenseCell.h
//  finanssis
//
//  Created by 魏希 on 16/7/30.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccountDetail;

@interface ExpenseCell : UITableViewCell
@property(nonatomic,strong) AccountDetail *accountDetail;
@property(nonatomic,weak) UIView *bgView;
@end

//
//  AddAccountDetailVC.h
//  shareFinansis
//
//  Created by 魏希 on 2017/5/30.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
@class AccountBook;

typedef void(^AddDetailBlock)();

@interface AddAccountDetailVC : BaseViewController
@property(nonatomic,strong) AccountBook *accountBook;
@property(nonatomic,copy) AddDetailBlock addDetailBlock;
@end

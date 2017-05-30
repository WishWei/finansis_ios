//
//  AccountDetailVC.h
//  shareFinansis
//
//  Created by 魏希 on 2017/5/30.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AccountBook.h"

@interface AccountDetailVC : BaseViewController
@property(nonatomic,strong) AccountBook *accountBook;
@end

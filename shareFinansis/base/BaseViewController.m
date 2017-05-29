//
//  BaseViewController.m
//  finanssis
//
//  Created by 魏希 on 16/7/27.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
}

- (CGFloat)viewBeginOriginY{
    if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)] && self.automaticallyAdjustsScrollViewInsets)return 0;
    else return 64;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

//
//  BaseNavViewController.m
//  finanssis
//
//  Created by 魏希 on 16/7/27.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import "BaseNavViewController.h"
#import "Theme.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:THEME_COLOR,NSForegroundColorAttributeName,[UIFont  boldSystemFontOfSize:19], NSFontAttributeName, nil]];
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationBar setTintColor:THEME_COLOR];
}



@end

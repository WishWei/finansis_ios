//
//  AppDelegate.m
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavViewController.h"
#import "IQKeyboardManager.h"
#import "LoginVC.h"
#import "AccountBookListVC.h"
#import "SystemHudView.h"
#import "NetWorkManager.h"
#import "ResponseBean.h"
#import "User.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    AccountBookListVC *vc=[[AccountBookListVC alloc] init];
    BaseNavViewController *nav=[[BaseNavViewController alloc] initWithRootViewController:vc];
    self.window.rootViewController=nav;
    [self.window makeKeyAndVisible];
    IQKeyboardManager *man = [IQKeyboardManager sharedManager];
    man.enableAutoToolbar = YES;
    man.enable = YES;
    [[Global shareInstance] loadTypes];
    [self autoLogin];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)autoLogin{
    User *user = [[Global shareInstance] lastLoginUser];
    if(user == nil) {
        LoginVC *vc = [[LoginVC alloc] init];
        BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
        [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
    }
    
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USER_PASSWORD];

    [[SystemHudView sharedInstance] showWaitHudViewWithTitle:@"登录中..."];
    __weak typeof(self) weakSelf = self;
    [[NetWorkManager shareInstance] loginWithName:user.name withPassword:password withBlock:^(id data, NSError *error) {
        ResponseBean *responseBean = data;
        
        if([REQEUST_SUCCESS isEqualToString:responseBean.code]) {
            User *user =  [User mj_objectWithKeyValues: responseBean.content];
            //保存登录用户到本地
            [[Global shareInstance] saveLoginUser:user];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SystemHudView sharedInstance] hideHUDView];
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SystemHudView sharedInstance] showFailedHudViewWithTitle:responseBean.message];
                [[SystemHudView sharedInstance] hideHUDViewAfterDelay:1];
                LoginVC *vc = [[LoginVC alloc] init];
                BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:vc];
                [weakSelf.window.rootViewController presentViewController:nav animated:YES completion:nil];
            });
        }
    }];
}


@end

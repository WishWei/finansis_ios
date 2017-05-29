//
//  LoginVC.m
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import "LoginVC.h"
#import "NetWorkManager.h"
#import "ResponseBean.h"
#import "User.h"
#import "SystemHudView.h"
#import "AccountBookListVC.h"
#import "BaseNavViewController.h"

@interface LoginVC ()
@property(nonatomic,weak) UITextField *nameTextField;
@property(nonatomic,weak) UITextField *passwordTextField;
@property(nonatomic,weak) UIButton *loginBtn;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
    //设置表单默认值
    [self configDefaultFields];
}


- (void)configView {
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:14.0f];
    nameLabel.textColor = COLOR_TEXT;
    nameLabel.text = @"账号：";
    [self.view addSubview:nameLabel];
    
    UITextField *nameTextField = [[UITextField alloc] init];
    nameTextField.textColor = COLOR_TEXT;
    nameTextField.font = [UIFont systemFontOfSize:14.0f];
    nameTextField.placeholder = @"请输入账号";
    [self.view addSubview:nameTextField];
    self.nameTextField = nameTextField;
    
    UILabel *passwordLabel = [[UILabel alloc] init];
    passwordLabel.font = [UIFont systemFontOfSize:14.0f];
    passwordLabel.textColor = COLOR_TEXT;
    passwordLabel.text = @"密码：";
    [self.view addSubview:passwordLabel];
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.textColor = COLOR_TEXT;
    passwordTextField.font = [UIFont systemFontOfSize:14.0f];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.secureTextEntry = YES;
    [self.view addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    UIButton *loginBtn = [[UIButton alloc] init];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    loginBtn.backgroundColor = THEME_COLOR;
    loginBtn.layer.cornerRadius = 5.0;
    [loginBtn addTarget:self action:@selector(loginBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    
    
    nameLabel.sd_layout.leftSpaceToView(self.view, 15).topSpaceToView(self.view, 80).heightIs(40).widthIs(60);
    nameTextField.sd_layout.leftSpaceToView(nameLabel, 5).topEqualToView(nameLabel).heightIs(40).rightSpaceToView(self.view, 15);
    passwordLabel.sd_layout.leftSpaceToView(self.view, 15).topSpaceToView(nameLabel, 10).heightIs(40).widthIs(60);
    passwordTextField.sd_layout.leftSpaceToView(passwordLabel, 5).topEqualToView(passwordLabel).heightIs(40).rightSpaceToView(self.view, 15);
    loginBtn.sd_layout.widthIs(200).heightIs(40).centerXEqualToView(self.view).bottomSpaceToView(self.view, 40);
}

- (void)configDefaultFields {
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USER_NAME];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_USER_PASSWORD];
    self.nameTextField.text = name;
    self.passwordTextField.text = password;
}


- (void)loginBtnPress:(UIButton *) sender {
    NSString *name = self.nameTextField.text;
    name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if(name.length <= 0) {
        [[SystemHudView sharedInstance] showFailedHudViewWithTitle:@"请输入账号"];
        [[SystemHudView sharedInstance] hideHUDViewAfterDelay:1];
        return;
    }
    NSString *password = self.passwordTextField.text;
    if(password.length <= 0) {
        [[SystemHudView sharedInstance] showFailedHudViewWithTitle:@"请输入密码"];
        [[SystemHudView sharedInstance] hideHUDViewAfterDelay:1];
        return;
    }
    [[SystemHudView sharedInstance] showWaitHudViewWithTitle:@"登录中..."];
    __weak typeof(self) weakSelf = self;
    [[NetWorkManager shareInstance] loginWithName:name withPassword:password withBlock:^(id data, NSError *error) {
        ResponseBean *responseBean = data;
        
        if([REQEUST_SUCCESS isEqualToString:responseBean.code]) {
            User *user =  [User mj_objectWithKeyValues: responseBean.content];
            //保存登录用户到本地
            [[Global shareInstance] saveLoginUser:user];
            [[NSUserDefaults standardUserDefaults] setObject:name forKey:LOGIN_USER_NAME];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:LOGIN_USER_PASSWORD];
            [[NSUserDefaults standardUserDefaults] synchronize];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SystemHudView sharedInstance] hideHUDView];
                [weakSelf dismissViewControllerAnimated:YES completion:^{
                    BaseNavViewController *nav = (BaseNavViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
                    AccountBookListVC *accountBookListVC = [[nav viewControllers] objectAtIndex:0];
                    [accountBookListVC reloadData];
                }];
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SystemHudView sharedInstance] showFailedHudViewWithTitle:responseBean.message];
                [[SystemHudView sharedInstance] hideHUDViewAfterDelay:1];
            });
        }
    }];
}

@end

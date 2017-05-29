//
//  User.h
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>
//id
@property(nonatomic,strong) NSString *ID;
//姓名
@property(nonatomic,strong) NSString *name;
//密码
@property(nonatomic,strong) NSString *password;
//性别
@property(nonatomic,strong) NSString *sex;
//上次登录时间
@property(nonatomic,strong) NSString *lastLogin;
//状态 1正常 0删除
@property(nonatomic,strong) NSString *status;
//创建时间
@property(nonatomic,strong) NSString *createTime;
@end

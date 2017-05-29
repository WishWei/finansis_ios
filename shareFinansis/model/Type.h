//
//  Type.h
//  finanssis
//
//  Created by 魏希 on 16/7/27.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Type : NSObject
@property(nonatomic,strong)NSString *id_;
@property(nonatomic,strong)NSString *enName;
@property(nonatomic,strong)NSString *cnName;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,assign)BOOL isAddByUser;
@end

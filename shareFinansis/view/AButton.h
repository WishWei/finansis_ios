//
//  AButton.h
//  1919
//
//  Created by 罗何 on 15/9/22.
//  Copyright (c) 2015年 罗何. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AButton : UIButton
@property(nonatomic,assign) CGRect imageFrame;
@property(nonatomic,assign) CGRect titleFrame;

@property(nonatomic,strong) id userInfo;

@property(nonatomic,assign) BOOL autoJust;

@end

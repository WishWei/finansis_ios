//
//  ZPNumberKeyboard.h
//  WGZY
//
//  Created by administrator on 16/2/24.
//  Copyright © 2016年 zp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZPNumberKeyboard;

@protocol KeyboardDelegate <NSObject>

- (void)sureBtnPress:(ZPNumberKeyboard*)keyboard;

@end

@interface ZPNumberKeyboard : UIView

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic,weak,nullable) id<KeyboardDelegate> delegate;

@end

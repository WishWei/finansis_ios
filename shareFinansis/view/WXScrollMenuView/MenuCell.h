//
//  MenuCell.h
//  finanssis
//
//  Created by 魏希 on 16/7/27.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuCell;

@protocol MenuCellDelegate <NSObject>

- (void)didSelectedWithMenuCell:(MenuCell*)cell withIndex:(NSInteger) index;

@end

@interface MenuCell : UIView
@property(nonatomic,assign) BOOL isSelected;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,weak,nullable) id<MenuCellDelegate> delegate;
- (CGRect)imageFrame;
@end

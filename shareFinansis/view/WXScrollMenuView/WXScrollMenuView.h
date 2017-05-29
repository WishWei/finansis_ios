//
//  WXScrollMenuView.h
//  finanssis
//
//  Created by 魏希 on 16/7/27.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "MenuCell.h"
@class WXScrollMenuView;

@protocol WXScrollMenuViewDelegate <NSObject>

- (void)scrollMenuView:(WXScrollMenuView*)scrollMenuView didSelectCellWithIndex:(NSInteger)index;

@end

@protocol WXScrollMenuViewDataSource <NSObject>
@required
- (NSInteger)numberWithscrollMenuView:(WXScrollMenuView*)scrollMenuView;
- (MenuCell*)scrollMenuView:(WXScrollMenuView*)scrollMenuView menuCellWithIndex:(NSInteger)index;
@end

@interface WXScrollMenuView : UIView
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,weak,nullable) id<WXScrollMenuViewDelegate> delegate;
@property(nonatomic,weak,nullable) id<WXScrollMenuViewDataSource> dataSource;

- (void)reloadData;
- (CGFloat)heightForView;
- (MenuCell*)cellForIndex:(NSInteger)index;
@end

//
//  MenuCell.m
//  finanssis
//
//  Created by 魏希 on 16/7/27.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import "MenuCell.h"
#import "AButton.h"
#import "Theme.h"

@interface MenuCell()
@property(nonatomic,weak) AButton *btn;
@end

@implementation MenuCell
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self _initViews];
    }
    return self;
}

- (void)_initViews{
    AButton *btn=[[AButton alloc] initWithFrame:self.bounds];
    btn.titleLabel.textAlignment=NSTextAlignmentCenter;
    btn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [btn setTitleColor:COLOR_TEXT_BLACK forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.btn=btn;
}

- (CGRect)imageFrame{
    return self.btn.imageView.frame;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected=isSelected;
//    UIColor *color=isSelected?[UIColor orangeColor]:[UIColor clearColor];
//    [self.btn setBackgroundColor:color];
}

- (void)setText:(NSString *)text{
    _text=text;
    [self.btn setTitle:text forState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)image{
    _image=image;
    [self.btn setImage:image forState:UIControlStateNormal];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.btn.frame=self.bounds;
    [self.btn setImageFrame:CGRectMake(10, 0, CGRectGetWidth(self.btn.frame)-20, CGRectGetHeight(self.btn.frame)-25)];
    [self.btn setTitleFrame:CGRectMake(0, CGRectGetHeight(self.btn.frame)-25, CGRectGetWidth(self.btn.frame), 20)];
}

- (void)btnPress:(UIButton*)sender{
    if([self.delegate respondsToSelector:@selector(didSelectedWithMenuCell:withIndex:)]){
        [self.delegate didSelectedWithMenuCell:self withIndex:self.index];
    }
}

@end

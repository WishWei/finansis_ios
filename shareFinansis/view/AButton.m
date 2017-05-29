//
//  AButton.m
//  1919
//
//  Created by 罗何 on 15/9/22.
//  Copyright (c) 2015年 罗何. All rights reserved.
//

#import "AButton.h"

@implementation AButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if(CGRectIsEmpty(self.titleFrame))
        return contentRect;
    return self.titleFrame;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectIsEmpty(self.imageFrame) ? contentRect : self.imageFrame;
}

- (void)setAutoJust:(BOOL)autoJust{
    _autoJust = autoJust;
}

- (void)_justFrame{
    UIImage *image = [self imageForState:UIControlStateNormal];
    NSString *title = [self titleForState:UIControlStateNormal];
    if(!image || title.length < 1) return;
    CGSize imageSize = image.size;
    CGSize titleWidth = [title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize selfSize = self.frame.size;
    CGFloat space = (selfSize.width - (imageSize.width + titleWidth.width))/2;
    self.titleFrame = CGRectMake(space, 0, titleWidth.width, selfSize.height);
    self.imageFrame = CGRectMake(space + titleWidth.width, selfSize.height/2 - imageSize.height/2 , imageSize.width, imageSize.height);
    self.clipsToBounds = NO;
    [self layoutSubviews];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    if(self.autoJust){[self _justFrame];}
}


- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    if(self.autoJust){[self _justFrame];}
}

@end

//
//  AccountBookCell.m
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import "AccountBookCell.h"
#import "AccountBook.h"

@interface AccountBookCell()
@property(nonatomic, weak) UILabel *nameLabel;
@end

@implementation AccountBookCell
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self configView];
    }
    return self;
}

- (void)configView {
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    nameLabel.backgroundColor = THEME_COLOR;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:16.0f];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
}

- (void)setAccountBook:(AccountBook *)accountBook {
    _accountBook = accountBook;
    self.nameLabel.text = accountBook.name;
}

@end

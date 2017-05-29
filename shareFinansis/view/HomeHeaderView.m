//
//  HomeHeaderView.m
//  finanssis
//
//  Created by 魏希 on 16/8/14.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import "HomeHeaderView.h"
#import "Theme.h"
#import "SDAutoLayout.h"

@interface HomeHeaderView()
@property(nonatomic, weak) UILabel *dateLabel;
@property(nonatomic, weak) UILabel *describeLabel;
@end

@implementation HomeHeaderView

- (instancetype)init{
    if(self = [super init]){
        [self _initViews];
    }
    return self;
}

- (void)_initViews{
    self.backgroundColor = COLOR_HEADER;
    
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.font = [UIFont systemFontOfSize:14.0];
    dateLabel.textColor = COLOR_TEXT_BLACK;
    dateLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    UILabel *describeLabel = [[UILabel alloc] init];
    describeLabel.font = [UIFont systemFontOfSize:14.0];
    describeLabel.textColor = COLOR_TEXT;
    describeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:describeLabel];
    self.describeLabel = describeLabel;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_SEPARATE;
    [self addSubview:lineView];
    
    self.dateLabel.sd_layout.leftSpaceToView(self,15).topEqualToView(self).bottomEqualToView(self).widthIs(100);
    self.describeLabel.sd_layout.leftSpaceToView(self,10).topEqualToView(self).bottomEqualToView(self).rightSpaceToView(self,15);
    lineView.sd_layout.leftEqualToView(self).rightEqualToView(self).bottomEqualToView(self).heightIs(1);
}

- (void)setDateString:(NSString *)dateString{
    _dateString = dateString;
    self.dateLabel.text = _dateString;
}

- (void)setCostMoney:(double)costMoney{
    _costMoney = costMoney;
    self.describeLabel.text = [NSString stringWithFormat:@"花费%.2f",_costMoney];
}

@end

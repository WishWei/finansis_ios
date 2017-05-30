//
//  SummaryHeader.m
//  finanssis
//
//  Created by 魏希 on 16/8/9.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import "SummaryHeader.h"
#import "SDAutoLayout.h"
#import "Theme.h"
#import "AccountSummary.h"

@interface SummaryHeader()
@property (nonatomic, strong) UILabel *costLabel;
@end

@implementation SummaryHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initViews];
    }
    return self;
}

- (void)initViews{
    
    UILabel *costLabel = [[UILabel alloc] init];
    costLabel.textColor = COLOR_TEXT_BLACK;
    costLabel.font = [UIFont systemFontOfSize:16.0f];
    costLabel.numberOfLines = 0;
    costLabel.text = @"0条明细 总金额：0.00元";
    [self addSubview:costLabel];
    self.costLabel = costLabel;
    
    self.costLabel.sd_layout.leftSpaceToView(self,20).topEqualToView(self).bottomEqualToView(self).rightSpaceToView(self, 20);
    
}

- (void)setAccountSummary:(AccountSummary *)accountSummary {
    _accountSummary = accountSummary;
    self.costLabel.text = [NSString stringWithFormat:@"%d条明细 总金额：%.2f元", accountSummary.detailCount, accountSummary.totalMoney];
}

@end

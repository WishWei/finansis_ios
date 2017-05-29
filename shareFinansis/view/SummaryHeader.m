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

@interface SummaryHeader()
@property (nonatomic, strong) UIButton *dateBtn;
@property (nonatomic, strong) UILabel *costLabel;
@property (nonatomic, strong) NSDateFormatter *fmt;
@end

@implementation SummaryHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initViews];
    }
    return self;
}

- (void)initViews{
    UIButton *dateBtn = [[UIButton alloc] init];
    [dateBtn setTitleColor:COLOR_TEXT_BLACK forState:UIControlStateNormal];
    dateBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [dateBtn setTitle:@"本月" forState:UIControlStateNormal];
    [dateBtn setImage:[UIImage imageNamed:@"triangle"] forState:UIControlStateNormal];
    dateBtn.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    dateBtn.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    dateBtn.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    [dateBtn addTarget:self action:@selector(dateBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:dateBtn];
    self.dateBtn = dateBtn;
    
    UILabel *costLabel = [[UILabel alloc] init];
    costLabel.textColor = COLOR_TEXT_BLACK;
    costLabel.font = [UIFont systemFontOfSize:16.0f];
    costLabel.numberOfLines = 0;
    costLabel.text = @"花费：0.00";
    [self addSubview:costLabel];
    self.costLabel = costLabel;
    
    self.dateBtn.sd_layout.leftEqualToView(self).topEqualToView(self).bottomEqualToView(self).widthIs(120);
    self.costLabel.sd_layout.leftSpaceToView(self.dateBtn,50).topEqualToView(self).bottomEqualToView(self).rightEqualToView(self);
    
}

- (void)dateBtnPress:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(didDateBtnPress)]){
        [self.delegate didDateBtnPress];
    }
}

- (NSDateFormatter *)fmt{
    if(!_fmt){
        _fmt = [[NSDateFormatter alloc] init];
        _fmt.dateFormat = @"yyyy年MM月";
    }
    return _fmt;
}

- (void)setDate:(NSDate *)date{
    _date =date;
    [self.dateBtn setTitle:[self.fmt stringFromDate:self.date] forState:UIControlStateNormal];
}

- (void)setSum:(double)sum{
    _sum = sum;
    self.costLabel.text = [NSString stringWithFormat:@"花费：%.2f",sum];
}

@end

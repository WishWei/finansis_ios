//
//  MonthPickerView.m
//  finanssis
//
//  Created by 魏希 on 16/8/20.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import "MonthPickerView.h"
#import "Theme.h"

@interface MonthPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, weak) UIButton *cancelBtn;
@property (nonatomic, weak) UIButton *sureBtn;
@property (nonatomic, strong) NSDateFormatter *fmt;
@property (nonatomic, weak) UIPickerView *datePickerView;
@end

@implementation MonthPickerView

- (instancetype)init {
    if(self == [super init]){
        [self initSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]){
        [self initSubView];
    }
    return self;
}

- (NSDateFormatter *)fmt {
    if(!_fmt){
        _fmt = [[NSDateFormatter alloc] init];
    }
    return _fmt;
}

- (void)initSubView{
    self.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [cancelBtn addTarget:self action:@selector(cancelBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    self.cancelBtn = cancelBtn;
    
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    sureBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [sureBtn addTarget:self action:@selector(sureBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sureBtn];
    self.sureBtn = sureBtn;
    
    UIPickerView *datePickerView = [[UIPickerView alloc] init];
    datePickerView.dataSource = self;
    datePickerView.delegate = self;
    [self addSubview:datePickerView];
    self.datePickerView = datePickerView;
    
    self.cancelBtn.sd_layout.leftSpaceToView(self, 0).topEqualToView(self).widthIs(80).heightIs(40);
    self.sureBtn.sd_layout.rightSpaceToView(self, 0).topEqualToView(self).widthIs(80).heightIs(40);
    self.datePickerView.sd_layout.topSpaceToView(self.cancelBtn, 0).leftSpaceToView(self, 15).rightSpaceToView(self, 15).bottomSpaceToView(self, 20);
}

- (void)cancelBtnPress:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(didCancelBtnPressWithPickerView:)]){
        [self.delegate didCancelBtnPressWithPickerView:self];
    }
}

- (void)sureBtnPress:(UIButton *)sender {
    if([self.delegate respondsToSelector:@selector(didSureBtnPressWithPickerView:WithDate:)]){
        int year = self.endYear - (int)[self.datePickerView selectedRowInComponent:0];
        int month = (int)[self.datePickerView selectedRowInComponent:1] + 1;
        NSDateFormatter *fmt =[[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM";
        NSString *dateStr = [NSString stringWithFormat:@"%d-%d",year,month];
        NSDate *date = [fmt dateFromString:dateStr];
        [self.delegate didSureBtnPressWithPickerView:self WithDate:date];
    }
}

- (void)setSelectedDate:(NSDate *)selectedDate {
    _selectedDate = selectedDate;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:selectedDate];
    int year = (int)[components year];
    int month = (int)[components month];
    if(self.startYear <= year && self.endYear >= year){
        int yearIndex = self.endYear - year;
        int monthIndex = month - 1;
        [self.datePickerView selectRow:yearIndex inComponent:0 animated:NO];
        [self.datePickerView selectRow:monthIndex inComponent:1 animated:NO];
    }
    
}

#pragma mark UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(self.endYear < self.startYear){
        return 0;
    }
    if(component == 0) {
        return self.endYear - self.startYear + 1;
    }else if(component == 1){
        return 12;
    }
    return 0;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0) {
        return [NSString stringWithFormat:@"%ld年",self.endYear - row];
    }else if(component == 1){
        return [NSString stringWithFormat:@"%ld月",row+1];
    }
    return @"";
}

@end

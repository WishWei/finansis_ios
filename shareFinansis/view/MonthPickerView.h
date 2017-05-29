//
//  MonthPickerView.h
//  finanssis
//
//  Created by 魏希 on 16/8/20.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MonthPickerView;

@protocol MonthPickerViewDelegate <NSObject>

- (void)didCancelBtnPressWithPickerView:(MonthPickerView *)pickerView;

- (void)didSureBtnPressWithPickerView:(MonthPickerView *)pickerView WithDate:(NSDate *)date;

@end

@interface MonthPickerView : UIView
@property (nonatomic, assign) int startYear;
@property (nonatomic, assign) int endYear;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, weak) id <MonthPickerViewDelegate> delegate;
@end

//
//  SummaryHeader.h
//  finanssis
//
//  Created by 魏希 on 16/8/9.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SummaryHeaderDelegate <NSObject>

- (void)didDateBtnPress;

@end

@interface SummaryHeader : UIView
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) double sum;
@property (nonatomic ,weak) id <SummaryHeaderDelegate> delegate;
@end

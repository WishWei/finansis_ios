//
//  AddAccountDetailVC.m
//  shareFinansis
//
//  Created by 魏希 on 2017/5/30.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import "AddAccountDetailVC.h"
#import "ZPNumberKeyboard.h"
#import "WXScrollMenuView.h"
#import "Type.h"
#import "Expense.h"
#import "AccountDetailVC.h"
#import "Common.h"
#import "Theme.h"
#import "NSString+Extension.h"
#import "THDatePickerViewController.h"

@interface AddAccountDetailVC()<WXScrollMenuViewDelegate,WXScrollMenuViewDataSource,KeyboardDelegate,THDatePickerDelegate>
@property(nonatomic,weak) UILabel *moneyLabel;
@property(nonatomic,weak) UIView *bottomView;
@property(nonatomic,weak) UIImageView *iconView;
@property(nonatomic,weak) UILabel *typeLabel;
@property(nonatomic,weak) WXScrollMenuView *menuView;
@property(nonatomic,weak) UITextField *titleField;
@property(nonatomic,weak) UITextField *remark;
@property(nonatomic,weak) UIView *toolBar;
@property(nonatomic,weak) UIButton *dateBtn;
@property(nonatomic,weak) UIButton *remarkBtn;
@property(nonatomic,weak) CALayer *animationLayer;
@property(nonatomic,strong) NSArray *types;
@property(nonatomic,strong) Type *selectedType;
@property(nonatomic,strong) NSDate *selectedDate;
@property(nonatomic,strong) NSDateFormatter *dateFmt;
@property(nonatomic,strong) THDatePickerViewController *datePicker;
@end

@implementation AddAccountDetailVC
- (void)viewDidLoad{
    [super viewDidLoad];
    self.types = [Global shareInstance].categories;
    self.dateFmt=[[NSDateFormatter alloc] init];
    self.dateFmt.dateFormat=@"yyyy-MM-dd";
    [self _initViews];
    self.selectedType=[self.types firstObject];
    self.selectedDate=[NSDate date];
}

-(void)_initViews{
    self.title=@"记一笔";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissBtnPress:)];
    self.view.backgroundColor=[UIColor whiteColor];
    
    WXScrollMenuView *menuView=[[WXScrollMenuView alloc] init];
    menuView.delegate=self;
    menuView.dataSource=self;
    [self.view addSubview:menuView];
    self.menuView=menuView;
    
    UIView *bottomView=[[UIView alloc] init];
    bottomView.backgroundColor=COLOR_PAGE_BG;
    [self.view addSubview:bottomView];
    self.bottomView=bottomView;
    
    UIImageView *iconView=[[UIImageView alloc] init];
    [self.bottomView addSubview:iconView];
    self.iconView=iconView;
    
    UILabel *typeLabel=[[UILabel alloc] init];
    typeLabel.font = [UIFont systemFontOfSize:16.0];
    typeLabel.textColor = COLOR_TEXT_BLACK;
    [self.bottomView addSubview:typeLabel];
    self.typeLabel=typeLabel;
    
    UILabel *moneyLabel=[[UILabel alloc] init];
    moneyLabel.font = [UIFont systemFontOfSize:16.0];
    moneyLabel.textColor = COLOR_TEXT_BLACK;
    moneyLabel.textAlignment=NSTextAlignmentRight;
    moneyLabel.text=@"0";
    [self.bottomView addSubview:moneyLabel];
    self.moneyLabel=moneyLabel;
    
    UITextField *titleField=[[UITextField alloc] init];
    titleField.textAlignment=NSTextAlignmentLeft;
    titleField.font=[UIFont systemFontOfSize:14.0];
    titleField.placeholder = @"备注";
    titleField.hidden=YES;
    [self.view addSubview:titleField];
    self.titleField=titleField;
    
    UIView *inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    inputAccessoryView.backgroundColor=[UIColor whiteColor];
    UITextField *remark=[[UITextField alloc] initWithFrame:inputAccessoryView.bounds];
    remark.placeholder = @"备注";
    [inputAccessoryView addSubview:remark];
    titleField.inputAccessoryView=inputAccessoryView;
    self.remark=remark;
    
    ZPNumberKeyboard *keyboard=[[ZPNumberKeyboard alloc] init];
    keyboard.delegate=self;
    keyboard.textLabel=moneyLabel;
    [self.view addSubview:keyboard];
    
    UIView *toolBar=[[UIView alloc] init];
    toolBar.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:toolBar];
    self.toolBar=toolBar;
    
    UIButton *dateBtn=[[UIButton alloc] init];
    dateBtn.layer.cornerRadius=5;
    dateBtn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    dateBtn.layer.borderWidth=1.0;
    dateBtn.titleLabel.font=[UIFont systemFontOfSize:14.0f];
    [dateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(dateBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar addSubview:dateBtn];
    self.dateBtn=dateBtn;
    
    UIButton *remarkBtn=[[UIButton alloc] init];
    [remarkBtn setImage:[UIImage imageNamed:@"btn_item_remark"] forState:UIControlStateNormal];
    [remarkBtn setImage:[UIImage imageNamed:@"btn_item_remark_pressed"] forState:UIControlStateSelected];
    [remarkBtn addTarget:self action:@selector(remarkBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar addSubview:remarkBtn];
    self.remarkBtn=remarkBtn;
    
    self.menuView.sd_layout.topSpaceToView(self.view,[self viewBeginOriginY]+20).leftEqualToView(self.view).rightEqualToView(self.view).heightIs([self.menuView heightForView]);
    
    self.titleField.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.moneyLabel,20).heightIs(40);
    keyboard.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(200);
    self.toolBar.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(keyboard,0).heightIs(40);
    self.dateBtn.sd_layout.leftSpaceToView(self.toolBar,10).topSpaceToView(self.toolBar,5).bottomSpaceToView(self.toolBar,5).widthIs(100);
    self.remarkBtn.sd_layout.rightSpaceToView(self.toolBar,10).topSpaceToView(self.toolBar,10).bottomSpaceToView(self.toolBar,10).widthEqualToHeight();
    self.bottomView.sd_layout.bottomSpaceToView(self.toolBar,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(55);
    self.iconView.sd_layout.leftSpaceToView(self.bottomView,10).topSpaceToView(self.bottomView,5).bottomSpaceToView(self.bottomView,5).widthEqualToHeight();
    self.typeLabel.sd_layout.leftSpaceToView(self.iconView,10).topEqualToView(self.bottomView).bottomEqualToView(self.bottomView).widthIs(180);
    self.moneyLabel.sd_layout.leftSpaceToView(self.typeLabel,10).rightSpaceToView(self.bottomView,10).topEqualToView(self.bottomView).bottomEqualToView(self.bottomView);
}

- (void)dismissBtnPress:(UIBarButtonItem*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dateBtnPress:(UIButton *)sender{
    [self presentSemiViewController:self.datePicker withOptions:@{
                                                                  KNSemiModalOptionKeys.pushParentBack    : @(NO),
                                                                  KNSemiModalOptionKeys.animationDuration : @(0.3),
                                                                  KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                                  }];
}

- (void)remarkBtnPress:(UIButton *)sender{
    [self.titleField becomeFirstResponder];
    [self.remark becomeFirstResponder];
    UIButton *maskView=[[UIButton alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    [maskView addTarget:self action:@selector(maskPress:) forControlEvents:UIControlEventTouchUpInside];
    maskView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
}

- (void)maskPress:(UIButton*)sender{
    [self.remark resignFirstResponder];
    [self.titleField resignFirstResponder];
    [sender removeFromSuperview];
    BOOL hasRemark=self.remark.text && ![[self.remark.text trim] isEqualToString:@""];
    self.remarkBtn.selected=hasRemark;
}

- (void)setSelectedType:(Type *)selectedType{
    _selectedType=selectedType;
    self.iconView.image=[UIImage imageNamed:selectedType.img];
    self.typeLabel.text=selectedType.cnName;
}

- (void)setSelectedDate:(NSDate *)selectedDate{
    _selectedDate=selectedDate;
    [self.dateBtn setTitle:[self.dateFmt stringFromDate:self.selectedDate] forState:UIControlStateNormal];
}

- (THDatePickerViewController*)datePicker{
    if(!_datePicker){
        _datePicker= [THDatePickerViewController datePicker];
        _datePicker.date = self.selectedDate;
        _datePicker.delegate = self;
        [_datePicker setAllowClearDate:NO];
        [_datePicker setClearAsToday:YES];
        [_datePicker setAutoCloseOnSelectDate:YES];
        [_datePicker setAllowSelectionOfSelectedDate:YES];
        [_datePicker setDisableHistorySelection:NO];
        [_datePicker setDisableFutureSelection:NO];
        [_datePicker setSelectedBackgroundColor:[UIColor colorWithRed:125/255.0 green:208/255.0 blue:0/255.0 alpha:1.0]];
        [_datePicker setCurrentDateColor:[UIColor colorWithRed:242/255.0 green:121/255.0 blue:53/255.0 alpha:1.0]];
        //        [_datePicker setDateHasItemsCallback:^BOOL(NSDate *date) {
        //            int tmp = (arc4random() % 30)+1;
        //            if(tmp % 5 == 0)
        //                return YES;
        //            return NO;
        //        }];
    }
    return _datePicker;
}

- (CALayer*)animationLayer{
    if(!_animationLayer){
        CALayer *layer=[CALayer layer];
        [self.view.layer addSublayer:layer];
        layer.hidden=YES;
        _animationLayer=layer;
    }
    return _animationLayer;
}

#pragma mark WXScrollMenuViewDelegate
- (void)scrollMenuView:(WXScrollMenuView*)scrollMenuView didSelectCellWithIndex:(NSInteger)index{
    if(!self.animationLayer.hidden){
        return;
    }
    MenuCell *cell=[scrollMenuView cellForIndex:index];
    CGRect frame=[cell convertRect:[cell imageFrame] toView:self.view];
    self.animationLayer.frame=frame;
    self.animationLayer.contents=(id)cell.image.CGImage;
    self.animationLayer.hidden=NO;
    
    CGRect endFrame=[self.bottomView convertRect:self.iconView.frame toView:self.view];
    
    CGPoint endpoint=CGPointMake(endFrame.origin.x+endFrame.size.width/2, endFrame.origin.y+endFrame.size.height/2);
    UIBezierPath *path=[UIBezierPath bezierPath];
    //动画起点
    CGRect rect=frame;
    CGPoint startPoint=CGPointMake(rect.origin.x +rect.size.width/2, rect.origin.y +rect.size.height/2);
    [path moveToPoint:startPoint];
    //贝塞尔曲线中间点
    float sx=startPoint.x;
    float sy=startPoint.y;
    float ex=endpoint.x;
    float ey=endpoint.y;
    float x=sx+(ex-sx)/2;
    float y=sy+(ey-sy)*0.5-200;
    CGPoint centerPoint=CGPointMake(x,y);
    [path addQuadCurveToPoint:endpoint controlPoint:centerPoint];
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //    animation.duration=0.5;
    animation.delegate=self;
    animation.autoreverses= NO;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *animation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    animation1.duration=0.5;
    animation1.autoreverses= NO;
    animation1.toValue=[NSNumber numberWithFloat:1.2];
    
    CAAnimationGroup *animationGroup=[CAAnimationGroup animation];
    animationGroup.animations=@[animation,animation1];
    animationGroup.duration=0.3;
    animationGroup.delegate=self;
    [self.animationLayer addAnimation:animationGroup forKey:@"throwAnimation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.selectedType=[self.types objectAtIndex:index];
    });
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.animationLayer.hidden=YES;
    [UIView animateWithDuration:0.3 animations:^{
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.3;
        NSMutableArray *values = [NSMutableArray array];
        //            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
        //            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = values;
        [self.iconView.layer addAnimation:animation forKey:nil];
    }];
}

#pragma mark WXScrollMenuViewDataSource
- (NSInteger)numberWithscrollMenuView:(WXScrollMenuView*)scrollMenuView{
    return self.types.count;
}
- (MenuCell*)scrollMenuView:(WXScrollMenuView*)scrollMenuView menuCellWithIndex:(NSInteger)index{
    Type *type = [self.types objectAtIndex:index];
    MenuCell *cell=[[MenuCell alloc] init];
    cell.image=[UIImage imageNamed:type.img];
    cell.text=type.cnName;
    return cell;
}

#pragma mark KeyboardDelegate
- (void)sureBtnPress:(ZPNumberKeyboard*)keyboard{
    if([self.moneyLabel.text doubleValue]==0){
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"金额不能为0" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        return;
    }
    Expense *expense=[[Expense alloc] init];
    expense.title=[self.remark.text trim];
    expense.typeId=self.selectedType.id_;
    expense.money=[self.moneyLabel.text doubleValue];
    expense.expenseDate=[self.dateFmt stringFromDate:self.selectedDate];
//    [[DBManager shareInstance] insertExpense:expense];
    //保存
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTY_REFRESH_HOME_DATA object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark THDatePickerDelegate
-(void)datePickerDonePressed:(THDatePickerViewController *)datePicker{
    [self dismissSemiModalViewWithCompletion:^{
        self.selectedDate=datePicker.date;
    }];
}
-(void)datePickerCancelPressed:(THDatePickerViewController *)datePicker{
    [self dismissSemiModalView];
}

@end

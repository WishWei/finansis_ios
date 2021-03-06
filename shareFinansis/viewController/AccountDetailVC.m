//
//  AccountDetailVC.m
//  shareFinansis
//
//  Created by 魏希 on 2017/5/30.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import "AccountDetailVC.h"
#import "MonthPickerView.h"
#import "SummaryHeader.h"
#import "HomeHeaderView.h"
#import "ExpenseCell.h"
#import "MJRefresh.h"
#import "NetWorkManager.h"
#import "ResponseBean.h"
#import "PageInfo.h"
#import "AccountDetail.h"
#import "AddAccountDetailVC.h"
#import "BaseNavViewController.h"
#import "SystemHudView.h"
#import "AccountSummary.h"

@interface AccountDetailVC()<UITableViewDelegate,UITableViewDataSource,MonthPickerViewDelegate>
@property(nonatomic,strong)NSMutableArray *accountDetails;
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)UIButton *addBtn;
@property(nonatomic,strong) NSDateFormatter *dateFmt;
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,assign) double sum;
@property(nonatomic,weak) SummaryHeader *summaryHeader;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int pageSize;
@end

@implementation AccountDetailVC
- (void)viewDidLoad{
    [super viewDidLoad];
    self.accountDetails = [NSMutableArray array];
    self.pageSize = 20;
    self.title = self.accountBook.name;
    self.dateFmt=[[NSDateFormatter alloc] init];
    self.dateFmt.dateFormat=@"yyyy-MM";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notyRefresh:) name:NOTY_REFRESH_HOME_DATA object:nil];
    [self configView];
    [self.tableView.mj_header beginRefreshing];
}

- (void)refreshData{
    [self loadTotalMoney];
    [self.accountDetails removeAllObjects];
    self.page = 0;
    [self.tableView.mj_footer resetNoMoreData];
    [self loadMore];
}

- (void)loadMore {
    __weak typeof(self) weakSelf = self;
    [[NetWorkManager shareInstance] accountDetailsWithBookId:self.accountBook.ID withPage:self.page withPageSize:self.pageSize
                                                   withBlock:^(id data, NSError *error) {
                                                       
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           [weakSelf.tableView.mj_header endRefreshing];
                                                           [weakSelf.tableView.mj_footer endRefreshing];
                                                       });
        ResponseBean *responseBean = data;
        if([REQEUST_SUCCESS isEqualToString:responseBean.code]) {
            PageInfo *pageInfo = [PageInfo mj_objectWithKeyValues: responseBean.content];
            NSArray *accountDetails = [AccountDetail mj_objectArrayWithKeyValuesArray:pageInfo.items];
            if([accountDetails count] <= 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                });
            }
            if(pageInfo.page == pageInfo.totalPage) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.accountDetails addObjectsFromArray:accountDetails];
                [weakSelf.tableView reloadData];
            });
            weakSelf.page ++;
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SystemHudView sharedInstance] showFailedHudViewWithTitle:responseBean.message];
                [[SystemHudView sharedInstance] hideHUDViewAfterDelay:1];
            });
        }
    }];

}

- (void)loadTotalMoney {
    [[NetWorkManager shareInstance] accountTotalMoneyWithBookId:self.accountBook.ID withBlock:^(id data, NSError *error) {
        ResponseBean *responseBean = data;
        if([REQEUST_SUCCESS isEqualToString:responseBean.code]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                AccountSummary *accountSummary =  [AccountSummary mj_objectWithKeyValues: responseBean.content];
                self.summaryHeader.accountSummary = accountSummary;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[SystemHudView sharedInstance] showFailedHudViewWithTitle:responseBean.message];
                [[SystemHudView sharedInstance] hideHUDViewAfterDelay:1];
            });
        }
    }];
}

- (void)configView{
    self.view.backgroundColor=[UIColor whiteColor];
    UITableView *tableView=[[UITableView alloc] init];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    SummaryHeader *summaryHeader = [[SummaryHeader alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
    tableView.tableHeaderView = summaryHeader;
    self.summaryHeader = summaryHeader;
    tableView.tableFooterView=[[UIView alloc] init];
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    tableView.mj_footer=[MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView=tableView;
    
    UIButton *addBtn=[[UIButton alloc] init];
    addBtn.backgroundColor=[UIColor whiteColor];
    [addBtn setTitle:@"记一笔" forState:UIControlStateNormal];
    [addBtn setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    addBtn.titleLabel.font=[UIFont systemFontOfSize:14.0f];
    [addBtn addTarget:self action:@selector(addBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    self.addBtn=addBtn;
    
    UIView *lineView=[[UIView alloc] init];
    lineView.backgroundColor=[UIColor lightGrayColor];
    [self.addBtn addSubview:lineView];
    
    self.addBtn.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(50);
    self.tableView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view,[self viewBeginOriginY]).bottomSpaceToView(self.addBtn,0);
    lineView.sd_layout.leftEqualToView(self.addBtn).rightEqualToView(self.addBtn).topEqualToView(self.addBtn).heightIs(1);
}


- (void)addBtnPress:(UIButton*)sender{
    AddAccountDetailVC *vc=[[AddAccountDetailVC alloc] init];
    vc.accountBook = self.accountBook;
    vc.addDetailBlock = ^{
        [self.tableView.mj_header beginRefreshing];
    };
    BaseNavViewController *nav=[[BaseNavViewController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.accountDetails count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseId = @"expenseCell";
    ExpenseCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseId];
    if(cell==nil){
        cell=[[ExpenseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.bgView.backgroundColor = indexPath.row%2 == 0 ? COLOR_PAGE_BG : [UIColor whiteColor];
    if(indexPath.row < [self.accountDetails count]) {
        AccountDetail *accountDetail = [self.accountDetails objectAtIndex:indexPath.row];
        cell.accountDetail = accountDetail;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{return YES;}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{return NO;}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{return UITableViewCellEditingStyleDelete;}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(editingStyle == UITableViewCellEditingStyleDelete){
//        DateExpense *dateExpense=[self.dateExpenses objectAtIndex:indexPath.section];
//        Expense *expense=[dateExpense.expenses objectAtIndex:indexPath.row];
//        if([[DBManager shareInstance] deleteExpenseWithId:expense.id_]){
//            [dateExpense.expenses removeObject:expense];
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//        }
//    }
}

#pragma mark MonthPickerViewDelegate
- (void)didCancelBtnPressWithPickerView:(MonthPickerView *)pickerView {
//    [self dismissSemiModalView];
}

- (void)didSureBtnPressWithPickerView:(MonthPickerView *)pickerView WithDate:(NSDate *)date {
//    [self dismissSemiModalView];
//    self.date = date;
//    [self refreshData];
}

- (void)notyRefresh:(NSNotificationCenter*)noty{
    [self refreshData];
}



@end

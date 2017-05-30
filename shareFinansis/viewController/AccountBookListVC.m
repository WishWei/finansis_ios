//
//  AccountBookListVC.m
//  shareFinansis
//
//  Created by 魏希 on 2017/5/29.
//  Copyright © 2017年 魏希. All rights reserved.
//

#import "AccountBookListVC.h"
#import "MJRefresh.h"
#import "AccountBookCell.h"
#import "AccountBook.h"
#import "NetWorkManager.h"
#import "ResponseBean.h"
#import "SystemHudView.h"
#import "PageInfo.h"
#import "AccountDetailVC.h"

@interface AccountBookListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,weak) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *books;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) int pageSize;

@end

@implementation AccountBookListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的账本";
    self.books = [NSMutableArray array];
    self.pageSize = 20;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, [self viewBeginOriginY], CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-[self viewBeginOriginY]) collectionViewLayout:flowLayout];
    [collectionView registerClass:[AccountBookCell class] forCellWithReuseIdentifier:@"accountBookCell"];
    self.collectionView=collectionView;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.collectionView.mj_footer=[MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    [self.view addSubview:collectionView];
    
    [self.collectionView.mj_header beginRefreshing];
}

- (void)reloadData {
    [self.collectionView.mj_header beginRefreshing];
}

- (void)refreshData {
    [self.books removeAllObjects];
    self.page = 0;
    [self.collectionView.mj_footer resetNoMoreData];
    [self loadMore];
}

- (void)loadMore {
    __weak typeof(self) weakSelf = self;
    [[NetWorkManager shareInstance] accountBooksWithPage:self.page withPageSize:self.pageSize withBlock:^(id data, NSError *error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        ResponseBean *responseBean = data;
        if([REQEUST_SUCCESS isEqualToString:responseBean.code]) {
            PageInfo *pageInfo = [PageInfo mj_objectWithKeyValues: responseBean.content];
            NSArray *books = [AccountBook mj_objectArrayWithKeyValuesArray:pageInfo.items];
            if([books count] > 0) {
                [weakSelf.books addObjectsFromArray:books];
            }else {
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            if(pageInfo.page == pageInfo.totalPage) {
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView reloadData];
            });
            weakSelf.page ++;
        }
    }];

}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.books.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((Iphone_Width-22)/2, (Iphone_Width-22)/2 + 65);
}

-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 6;
}

-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(6, 6, 6, 6);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AccountBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"accountBookCell" forIndexPath:indexPath];
    AccountBook *accountBook = [self.books objectAtIndex:indexPath.row];
    cell.accountBook = accountBook;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    AccountBook *accountBook = [self.books objectAtIndex:indexPath.row];
    if(accountBook) {
        AccountDetailVC *vc = [[AccountDetailVC alloc] init];
        vc.accountBook = accountBook;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end

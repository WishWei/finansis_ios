//
//  WXScrollMenuView.m
//  finanssis
//
//  Created by 魏希 on 16/7/27.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import "WXScrollMenuView.h"
#import "MenuCell.h"
#import "Common.h"

@interface WXScrollMenuView()<MenuCellDelegate,UIScrollViewDelegate>
@property(nonatomic,assign) int cols;
@property(nonatomic,assign) int rows;
@property(nonatomic,weak) UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *cells;
@property(nonatomic,weak) UIPageControl *pageControl;
@end

@implementation WXScrollMenuView
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame: frame]){
        if(screenSizeInPix.height<=960){
            self.cols=6;
            self.rows=2;
        }else if(screenSizeInPix.height>960 && screenSizeInPix.height<=1136){
            self.cols=6;
            self.rows=3;
        }else if(screenSizeInPix.height>1136 && screenSizeInPix.height<=1334){
            self.cols=6;
            self.rows=3;
        }else{
            self.cols=6;
            self.rows=4;
        }
        [self _initSubViews];
    }
    return self;
}

- (void)_initSubViews{
    UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-20)];
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    scrollView.showsHorizontalScrollIndicator=NO;
    [self addSubview:scrollView];
    self.scrollView=scrollView;
    
    UIPageControl *pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), CGRectGetWidth(self.frame), 20)];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    pageControl.hidesForSinglePage=YES;
    [self addSubview:pageControl];
    self.pageControl=pageControl;
}

- (void)reloadData{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }

    NSInteger menuCount=0;
    if([self.dataSource respondsToSelector:@selector(numberWithscrollMenuView:)]){
        menuCount=[self.dataSource numberWithscrollMenuView:self];
    }
    if(self.selectedIndex>menuCount-1){
        self.selectedIndex=0;
    }
    self.cells=[NSMutableArray array];
    for (int i=0; i<menuCount; i++) {
       
        MenuCell *cell;
        if([self.dataSource respondsToSelector:@selector(scrollMenuView:menuCellWithIndex:)]){
            cell=[self.dataSource scrollMenuView:self menuCellWithIndex:i];
        }
        if(cell){
            cell.index=i;
            cell.delegate=self;
            [self.cells addObject:cell];
            [self.scrollView addSubview:cell];
        }
    }
    NSInteger pageCount=(self.cells.count-1)/(self.rows*self.cols)+1;
    if(pageCount<=0){
        pageCount=1;
    }
    self.pageControl.numberOfPages=pageCount;
}

- (void)setDataSource:(id<WXScrollMenuViewDataSource>)dataSource{
    _dataSource=dataSource;
    [self reloadData];
}

- (MenuCell*)cellForIndex:(NSInteger)index{
    return [self.cells objectAtIndex:index];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame=CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-20);
    self.pageControl.frame=CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), CGRectGetWidth(self.frame), 20);
    for (int i=0; i<self.cells.count; i++) {
        MenuCell *cell=[self.cells objectAtIndex:i];
        NSInteger pageNumber=i/(self.rows*self.cols);
        CGFloat cellWidth=CGRectGetWidth(self.scrollView.frame)/self.cols;
        CGFloat cellHeight=CGRectGetHeight(self.scrollView.frame)/self.rows;
        NSInteger pageCount=(self.cells.count-1)/(self.rows*self.cols)+1;
        if(pageCount<=0){
            pageCount=1;
        }
        self.scrollView.contentSize=CGSizeMake(pageCount*CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        
        CGFloat x=pageNumber*CGRectGetWidth(self.scrollView.frame)+cellWidth*(i%self.cols);
        CGFloat y=cellHeight*(i%(self.rows*self.cols)/self.cols);
        cell.frame=CGRectMake(x, y, cellWidth, cellHeight);
        cell.isSelected=self.selectedIndex==i;
        
    }
    
}

- (CGFloat)heightForView{
    return ([UIScreen mainScreen].bounds.size.width/self.cols+5)*self.rows+25;
}

#pragma mark menuCellDelegate
- (void)didSelectedWithMenuCell:(MenuCell*)cell withIndex:(NSInteger) index{
    self.selectedIndex=index;
    cell.isSelected=YES;
    if([self.delegate respondsToSelector:@selector(scrollMenuView:didSelectCellWithIndex:)]){
        [self.delegate scrollMenuView:self didSelectCellWithIndex:index];
    }
//    [self layoutSubviews];
}

#pragma mark scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page=scrollView.contentOffset.x/scrollView.bounds.size.width;
    self.pageControl.currentPage=page;
}


@end

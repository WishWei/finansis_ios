//
//  ExpenseCell.m
//  finanssis
//
//  Created by 魏希 on 16/7/30.
//  Copyright © 2016年 魏希. All rights reserved.
//

#import "ExpenseCell.h"
#import "SDAutoLayout.h"
#import "Theme.h"
#import "AccountDetail.h"

@interface ExpenseCell()
@property(nonatomic,weak)UIImageView *iconView;
@property(nonatomic,weak)UILabel *titleLabel;
@property(nonatomic,weak)UILabel *moneyLabel;
@property(nonatomic,weak)UILabel *nameLabel;
@property(nonatomic,weak)UILabel *dateLabel;
@end

@implementation ExpenseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initSubView];
    }
    return self;
}

- (void)_initSubView{
    UIView *bgView=[[UIView alloc] init];
    [self.contentView addSubview:bgView];
    self.bgView=bgView;
    
    UIImageView *iconView=[[UIImageView alloc] init];
    [self.bgView addSubview:iconView];
    self.iconView=iconView;
    
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.textColor = COLOR_TEXT_BLACK;
    nameLabel.font = [UIFont systemFontOfSize:16.0];
    nameLabel.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    UILabel *titleLabel=[[UILabel alloc] init];
    titleLabel.textColor = COLOR_TEXT_BLACK;
    titleLabel.font = [UIFont systemFontOfSize:14.0];
    titleLabel.textAlignment=NSTextAlignmentLeft;
    [self.bgView addSubview:titleLabel];
    self.titleLabel=titleLabel;
    
    UILabel *moneyLabel=[[UILabel alloc] init];
    moneyLabel.textColor = COLOR_TEXT;
    moneyLabel.font = [UIFont systemFontOfSize:16.0];
    moneyLabel.textAlignment=NSTextAlignmentRight;
    [self.bgView addSubview:moneyLabel];
    self.moneyLabel=moneyLabel;
    
    UILabel *dateLabel=[[UILabel alloc] init];
    dateLabel.textColor = COLOR_TEXT;
    dateLabel.font = [UIFont systemFontOfSize:12.0];
    dateLabel.textAlignment=NSTextAlignmentRight;
    [self.bgView addSubview:dateLabel];
    self.dateLabel=dateLabel;
    
    self.bgView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    self.iconView.sd_layout.leftSpaceToView(self.bgView,15).topSpaceToView(self.bgView,5).bottomSpaceToView(self.bgView,5).widthEqualToHeight();
    self.nameLabel.sd_layout.leftSpaceToView(self.iconView, 5).topSpaceToView(self.bgView, 10).heightIs(20).widthIs(200);;
    self.titleLabel.sd_layout.leftSpaceToView(self.iconView,5).topSpaceToView(self.nameLabel,0).bottomSpaceToView(self.bgView,5).widthIs(200);
    self.dateLabel.sd_layout.rightSpaceToView(self.bgView,15).topSpaceToView(self.bgView,5).leftSpaceToView(self.titleLabel,5).heightIs(20);
    self.moneyLabel.sd_layout.rightSpaceToView(self.bgView,15).topSpaceToView(self.dateLabel,5).bottomSpaceToView(self.bgView,5).leftSpaceToView(self.titleLabel,5);
}

- (void)setAccountDetail:(AccountDetail *)accountDetail {
    _accountDetail = accountDetail;
    NSString *imgName = [[Global shareInstance].categorieImgMap objectForKey:accountDetail.category];
    self.iconView.image = [UIImage imageNamed:imgName];
    self.nameLabel.text = accountDetail.userName;
    NSString *title = (accountDetail.remark && ![accountDetail.remark isEqualToString:@""])?accountDetail.remark:accountDetail.category;
    self.titleLabel.text = title;
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f元",accountDetail.money];
    self.dateLabel.text = accountDetail.accountTime;
}



@end

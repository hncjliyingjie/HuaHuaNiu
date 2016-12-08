//
//  HHHeaderView.h
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYModel.h"

@interface HHHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *ditieName;//地体广告
@property (weak, nonatomic) IBOutlet UILabel *miaoshuLbl;//描述内容
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;//价格
@property (weak, nonatomic) IBOutlet UILabel *loctionLbl;//位置
@property (weak, nonatomic) IBOutlet UILabel *coverNumberLbl;//受众人群
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;//起始时间
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;//类型
@property (weak, nonatomic) IBOutlet UILabel *guigeLbl;//规格
@property (weak, nonatomic) IBOutlet UIImageView *headImg;//头像
@property (weak, nonatomic) IBOutlet UILabel *dyrLbl;//代言人名字
@property (weak, nonatomic) IBOutlet UILabel *companyNameLbl;//公司名称
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *profielsHeight;

@property (nonatomic, weak) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIImageView *collectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;

@property (nonatomic, copy) void(^itemBlock)(NSInteger index);//点击图片的block传值
@property (weak, nonatomic) IBOutlet UIButton *imageAndTextButton;//图文详情按钮
@property (weak, nonatomic) IBOutlet UIButton *freebackButton;//他的评价按钮

+ (HHHeaderView *)headerView;

//通过model显示数据
- (void)showViewWithModel:(ZYModel *)model;
@end

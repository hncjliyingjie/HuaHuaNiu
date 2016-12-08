//
//  ZYTableViewCell.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/7.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZY_DataModel.h"
@interface ZYTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *plsLbl;//评论数
@property (weak, nonatomic) IBOutlet UILabel *liulanLbl;//浏览数
@property (weak, nonatomic) IBOutlet UILabel *frofiesLbl;//简介

@property (weak, nonatomic) IBOutlet UILabel *nameTitle;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *forfielsHeight;//简介的高度
-(void)setCellWithZYData:(ZY_DataModel *)model;

@end

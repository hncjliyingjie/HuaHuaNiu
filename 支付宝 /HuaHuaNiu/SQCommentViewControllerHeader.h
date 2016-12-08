//
//  SQCommentViewControllerHeader.h
//  HuaHuaNiu
//
//  Created by YongHeng on 16/8/4.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGFindModel.h"

@interface SQCommentViewControllerHeader : UIView

@property (nonatomic,strong) HGFindModel * model;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *lookImage;

@property (weak, nonatomic) IBOutlet UILabel *lookNumber;

@property (weak, nonatomic) IBOutlet UIImageView *pinglunImage;

@property (weak, nonatomic) IBOutlet UILabel *pinglunNumber;

@end

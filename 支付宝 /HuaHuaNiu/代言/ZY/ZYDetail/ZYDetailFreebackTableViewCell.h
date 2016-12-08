//
//  ZYDetailFreebackTableViewCell.h
//  HuaHuaNiu
//
//  Created by mac on 16/12/7.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYModel.h"

@interface ZYDetailFreebackTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *freebackLabel;
- (void)showDataWithModel:(ZYModel *)model;
@end

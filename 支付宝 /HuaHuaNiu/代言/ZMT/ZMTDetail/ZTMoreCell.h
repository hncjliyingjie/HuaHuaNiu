//
//  ZTMoreCell.h
//  HuaHuaNiu
//
//  Created by mac on 16/11/6.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMTDetailModel.h"

@interface ZTMoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;

- (void)showDataWithModel:(ZMTDetailModel *)model;
@end

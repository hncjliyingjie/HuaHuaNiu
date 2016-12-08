//
//  ZYDetailFreebackTableViewCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/12/7.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZYDetailFreebackTableViewCell.h"

@implementation ZYDetailFreebackTableViewCell
- (void)showDataWithModel:(ZYModel *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrlStr] placeholderImage:[UIImage imageNamed:@"Default"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", model.nickName];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", model.time];
    self.freebackLabel.text = [NSString stringWithFormat:@"%@", model.freebackStr];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

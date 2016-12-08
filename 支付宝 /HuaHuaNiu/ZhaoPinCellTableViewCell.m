//
//  ZhaoPinCellTableViewCell.m
//  HuaHuaNiu
//
//  Created by alex on 15/10/27.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "ZhaoPinCellTableViewCell.h"

@implementation ZhaoPinCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

//salary
-(void)makeCellWithModel:(ZhaoPinModel *)model{
    self.titleLB.text =model.title;
    self.timeLB.text =model.pubDate;
    self.numberLB.text =model.addPrice;
    self.placeLB.text =model.workPlace;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  MyQiuTableViewCell.m
//  HuaHuaNiu
//
//  Created by alex on 16/2/20.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "MyQiuTableViewCell.h"

@implementation MyQiuTableViewCell
-(void)makeCellWith:(QiuZhiModel *)model{
    self.timeLB.text =model.addTime;
    self.expLB.text =model.addPrice;
    self.placeLB.text=model.workPlace;
    self.titleLB.text=model.title;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

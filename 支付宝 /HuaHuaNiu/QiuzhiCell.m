//
//  QiuzhiCell.m
//  HuaHuaNiu
//
//  Created by alex on 15/10/26.
//  Copyright © 2015年 张燕. All rights reserved.
//

#import "QiuzhiCell.h"

@implementation QiuzhiCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)makeCellWith:(QiuZhiModel *)model{
    self.timeLB.text =model.addTime;
    self.expLB.text =model.addPrice;
    self.placeLB.text=model.workPlace;
    self.titleLB.text=model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

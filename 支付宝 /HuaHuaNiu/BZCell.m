//
//  BZCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/14.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "BZCell.h"

@implementation BZCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.slLbl.layer.cornerRadius=5;
    self.slLbl.layer.masksToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

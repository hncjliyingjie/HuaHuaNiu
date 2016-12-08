//
//  RZCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/16.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "RZCell.h"

@implementation RZCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.rzBtn.layer.cornerRadius=5;
    self.rzBtn.layer.borderWidth=1;
    self.rzBtn.layer.borderColor=[[UIColor colorWithRed:0.047 green:0.364 blue:0.662 alpha:1]CGColor];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

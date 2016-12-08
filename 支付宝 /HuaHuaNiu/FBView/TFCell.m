//
//  TFCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/17.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "TFCell.h"

@implementation TFCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *boardlineView=[self viewWithTag:1001];
    boardlineView.layer.cornerRadius=5;
    boardlineView.layer.borderWidth=0.5;
    boardlineView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

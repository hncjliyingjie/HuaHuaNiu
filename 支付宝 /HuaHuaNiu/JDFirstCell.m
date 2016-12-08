//
//  JDFirstCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "JDFirstCell.h"

@implementation JDFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layerView.layer.cornerRadius=5;
    self.layerView.layer.borderWidth=0.5;
    self.layerView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    
    self.secoundLayerView.layer.cornerRadius=5;
    self.secoundLayerView.layer.borderWidth=0.5;
    self.secoundLayerView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

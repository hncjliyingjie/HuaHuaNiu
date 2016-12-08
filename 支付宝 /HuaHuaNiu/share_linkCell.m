//
//  share_linkCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "share_linkCell.h"

@implementation share_linkCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bordView.layer.cornerRadius=5;
    
    self.shiliLbl.layer.cornerRadius=5;
    self.shiliLbl.layer.borderWidth=0.5;
    self.shiliLbl.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.yulanBtn.layer.cornerRadius=5;
    self.yulanBtn.layer.borderWidth=0.5;
    self.yulanBtn.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    self.fuzhiBtn.layer.cornerRadius=5;
    self.fuzhiBtn.layer.borderWidth=0.5;
    self.fuzhiBtn.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

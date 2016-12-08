//
//  JDCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/8.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "JDCell.h"

@implementation JDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)cellWithStyle{
    
    self.lineView.layer.cornerRadius=5;
    self.lineView.layer.borderWidth=1;
    self.lineView.layer.borderColor=[[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]CGColor];
    
    self.secoundView.layer.cornerRadius=5;
        
//    self.wxBtn.layer.cornerRadius=5;
//    self.wxBtn.layer.borderWidth=1;
//    self.wxBtn.layer.borderColor=[[UIColor colorWithRed:0.45 green:0.8 blue:0.63 alpha:1]CGColor ];
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  CYRUXCTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "CYRUXCTableViewCell.h"

@implementation CYRUXCTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)cellMakeWith:(NSString *)titleStr andimaArr:(NSString *)imaStr andconcentArr:(NSString *)concentStr{

    self.NmaeLabel.text = titleStr;
    self.CImaView.image= [UIImage imageNamed:imaStr];
    self.imageView.frame = CGRectMake(13, 12, 83, 62);
    // 一个字宽度
     CGFloat OneWith = 200/16.0;
    CGFloat Hang =concentStr.length *OneWith /(200 *(ConentViewWidth/320.0));
    
    self.ConcentLabel.frame =CGRectMake(104, 33, 200 *(ConentViewWidth/320.0) - 30, 15*Hang +15);
    self.ConcentLabel.text=concentStr;


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  SZTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-23.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "SZTableViewCell.h"

@implementation SZTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)SZCellMakeWithDIc:(NSDictionary *)dic{




    self.TImeLabel.text = [dic objectForKey:@"add_time"];
    float number =[[dic objectForKey:@"change_value"] floatValue];
    number/=100;
    self.SZlabel.text=[NSString stringWithFormat:@"￥ %.2f",number];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

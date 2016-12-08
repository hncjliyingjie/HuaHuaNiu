//
//  InComeTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "InComeTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation InComeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)INcellmakeWithDic:(NSDictionary *)dic{
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"logo"]]] placeholderImage:[UIImage imageNamed:@"default"]];

    self.NameLabel .text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

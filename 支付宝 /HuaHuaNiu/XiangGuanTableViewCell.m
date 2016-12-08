//
//  XiangGuanTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "XiangGuanTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation XiangGuanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)XiangguancellmakeWIthDic:(NSDictionary *)dic{
    
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"default_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    
    self.NameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];
    
    self.PricrLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
    
/*
 "default_image" = "data/files/mall/settings/default_goods_image.jpg";
 "goods_id" = 878;
 "goods_name" = "\U6c49\U4e3d\U8f69\U70e4\U8089\U8d85\U5e02";
 price = "35.00";
 },

 
 */




}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

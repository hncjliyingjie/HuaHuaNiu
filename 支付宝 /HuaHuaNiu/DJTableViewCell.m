//
//  DJTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "DJTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation DJTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)DJcellMakeWithDic:(NSDictionary *)dic{
    [self.ImageIma sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"default_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    
    self.NameLaebl.text =[NSString  stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];
   //价格
    self.FenLeiLabel.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"price"] floatValue]];
    
   // 售出
    self.JuLiLabel.text =[NSString stringWithFormat:@"售出:%@件",[dic objectForKey:@"selled_num"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  DIngDanceTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-28.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "DIngDanceTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation DIngDanceTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
//// 判断订单

-(void)cellMakeWIthDic:(NSDictionary *)dic{
    if ([dic objectForKey:@"goods_image"]) {
        [self.IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"goods_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    }else{
        [self.IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"default_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    }
    
    self.NameLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];
    self.PricecLabel.text =[NSString stringWithFormat:@"￥%@",[dic objectForKey:@"price"]];
    self.NumberLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"quantity"]];
    self.StatuLabel.hidden =YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

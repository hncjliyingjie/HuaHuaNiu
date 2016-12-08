//
//  PeisongTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-6.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "PeisongTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation PeisongTableViewCell

- (void)awakeFromNib {
    // Initialization code
   
    self.NameLabel.font =[UIFont   fontWithName:@"Hoefler Text" size:12];
    
    
}
-(void)cellMakeDataWithDic:(NSDictionary *)dic{
    self.NameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];
    self.PriceLabel.text=[NSString stringWithFormat:@"￥%@元",[dic objectForKey:@"price"]];

    [self.IcoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"default_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    self.StoreNameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"store_name"]];
    self.Sellabel.text=[NSString stringWithFormat:@"已售出%@件",[dic objectForKey:@"selled_num"]];
}
-(void)cellMakeDataWithDic1:(NSDictionary *)dic{
    self.NameLabel1.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];
    self.PriceLabel1.text=[NSString stringWithFormat:@"￥%@元",[dic objectForKey:@"price"]];
    
    [self.IcoImage1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"default_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    self.StoreNameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"store_name"]];
    self.Sellabel1.text=[NSString stringWithFormat:@"已售出%@件",[dic objectForKey:@"selled_num"]];
}
-(void)cellSearchWithDic:(NSDictionary *)dic{
    
    self.NameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];
    self.PriceLabel.text=[NSString stringWithFormat:@"￥%@元",[dic objectForKey:@"price"]];
   // self.StoreNameLabel.hidden =YES;
    self.StoreNameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"store_name"]];
    [self.IcoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"default_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
  
    self.Sellabel.text=[NSString stringWithFormat:@"已售出%@件",[dic objectForKey:@"sales"]];



}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

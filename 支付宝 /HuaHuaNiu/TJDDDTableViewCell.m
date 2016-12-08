//
//  TJDDDTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "TJDDDTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TJDDDTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)cellMakeWithDicss:(NSDictionary *)dic{
    float number =[[dic objectForKey:@"price"]floatValue] * [[dic objectForKey:@"quantity"]integerValue];
    self.XiaoJILabel.textAlignment = NSTextAlignmentRight;
    self.NameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];
    [self.ImaegICView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"goods_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    self.PriceLabel.text=[NSString stringWithFormat:@"￥ %@ x %@",[dic objectForKey:@"price"],[dic objectForKey:@"quantity"]];
    self.XiaoJILabel.text =[NSString stringWithFormat:@"小计:￥%.2f",number];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

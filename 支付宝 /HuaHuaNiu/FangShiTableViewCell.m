//
//  FangShiTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-16.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "FangShiTableViewCell.h"

@implementation FangShiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)cellMakeWithDicss:(NSDictionary *)dic{
    //zhifu
   
   self.TuPianImage.image =[UIImage imageNamed:[dic objectForKey:@"Image"]];
    self.ShuomingLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"description"]];
    self.NameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    NSString *xuan =[NSString stringWithFormat:@"%@",[dic objectForKey:@"xuan"]];
    if ([xuan isEqualToString:@"YES"]) {
        //选中
        //(@"选中");//该图标
        self.DianImageview.image =[UIImage imageNamed:@"zhi.png"];
    }
    else{
          //(@"为选中");
        self.DianImageview.image =[UIImage imageNamed:@"zhifu"];

    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

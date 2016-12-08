//
//  PLVsTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "PLVsTableViewCell.h"

@implementation PLVsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)PLCellMakeWithDic:(NSDictionary *)dic{

    self.UserNameLaebl.text = [NSString stringWithFormat:@"%@",[ dic objectForKey:@"buyer_name"]];//@"代言城的粉丝";

    
    double BDShijian =[[dic objectForKey:@"evaluation_time"] doubleValue];
    NSDate * BDdate =[NSDate dateWithTimeIntervalSince1970:BDShijian];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString * BDdataStr =[dateFormatter stringFromDate:BDdate];
  
    
   self.TImeLabel.text = [NSString stringWithFormat:@"%@",BDdataStr];;
    
    
    
   self.PingLunLabel.text =[NSString stringWithFormat:@"     %@",[ dic objectForKey:@"comment"]];
    CGFloat  HIghe;
    CGFloat with = 265*(ConentViewWidth/320.0);
    //  一个字的宽度  265/24
    //回复的行数
    int  hang   = self.PingLunLabel.text.length*(265/24.0)/with  + 1;
    HIghe  = 15*hang;
    self.PingLunLabel.numberOfLines = 0;
    self.PingLunLabel.frame =CGRectMake(self.PingLunLabel.frame.origin.x, self.PingLunLabel.frame.origin.y, ConentViewWidth - 20, HIghe);
   
    //NSString * str =[NSString stringWithFormat:@"%@",[dic objectForKey:@"reply"]];
    NSString * str =[NSString stringWithFormat:@"%@",[dic objectForKey:@"reply"]];

    
    if (str.length > 0) {
     self.HuiFuLabel.numberOfLines = 0;
   self.HuiFuLabel.text =[NSString stringWithFormat:@"     商家回复:%@",[dic objectForKey:@"reply"]];
// 一个字的宽度 265/24.0；
    CGFloat  HUHight ;
    CGFloat HUwith = 281*(ConentViewWidth/320.0);
    int  HUhang   = self.HuiFuLabel.text.length*(265/24.0)/with  + 1;
     HUHight = 15*HUhang  ;

    
    self.HuiFuLabel.frame =CGRectMake(self.HuiFuLabel.frame.origin.x, self.PingLunLabel.frame.size.height +self.PingLunLabel.frame.origin.y, HUwith,HUHight);
    }
 else{
     self.HuiFuLabel.hidden = YES;
 }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  DaiJinQTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "DaiJinQTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation DaiJinQTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)dajincellmakeWithDic:(NSDictionary *)dic{
    
    self.IconImage.layer.masksToBounds = YES;
    self.IconImage.layer.cornerRadius =32;
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl, [ dic objectForKey:@"logo"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    self.NameLabe.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"voucher_name"]];
    self.numberLabel.text =[NSString stringWithFormat:@"NO.:%@",[dic objectForKey:@"voucher_code"]];
    self.MianZhiLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];

    NSDate * Today =[NSDate date];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * inputString = [inputFormatter stringFromDate:Today];
    NSDate* inputDate = [inputFormatter dateFromString:inputString];
    NSTimeInterval  NowCha =[inputDate timeIntervalSince1970];
    NSString *BDShijian =[dic objectForKey:@"expiration_time"];
//    NSString * BDShijian =@"2015-10-11";
    inputDate = [inputFormatter dateFromString:BDShijian];
    NSTimeInterval  shijian =[inputDate timeIntervalSince1970];
    //(@"%f",shijian);
    //(@"%f",NowCha);
    double cha =NowCha - shijian;
    if(cha >0){// 过期
     self.tianshuLabel.text =[NSString stringWithFormat:@"代金券已过期"];
    }else{
        int tian =(int)cha/3600/24;
        if (-cha < 3600*24) {
            self.tianshuLabel.text =[NSString stringWithFormat:@"今日过期请注意"];
        }
        else{
            self.tianshuLabel.text =[NSString stringWithFormat:@"还有%d天过期",-tian];
        }
}

    self.Timerlabel.text =[dic objectForKey:@"expiration_time"];
/*
 Idcode = "";
 description = 1212;
 enddate = 1430323200;
 logo = "data/files/mall/voucher/2.jpg";
 "store_id" = 239;
 "surplus_days" = 11;
 value = 10;
 vid = 2;
 vname = "\U91d1\U5238\U540d";
*/

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

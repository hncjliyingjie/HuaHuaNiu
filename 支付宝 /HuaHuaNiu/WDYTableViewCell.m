//
//  WDYTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-18.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "WDYTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation WDYTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)makeCellWithModel:(AlexModel *)model{
    self.sharBtns.hidden = YES;
    self.shareImage.hidden = YES;
    self.SYtime.text =[NSString stringWithFormat:@"%@ 天",model.surplus_days];
    self.BDTimelabel.text= model.start_date;
    [self.IcinnnImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,model.store_logo]] placeholderImage:[UIImage imageNamed:@"default"]];
    self.momeylabel.text =model.money;
    self.NameLabel.text =model.store_name;
    
    /*
     "bind_days" = 122;
     "bind_endtime" = 1439471698;
     "bind_time" = 1428930898;
     bsid = 7;
     money = 0;
     "store_id" = 237;
     "store_logo" = "/data/files/mall/storelogo/140429073530997178.jpg";
     "store_name" = "\U7f18\U7f18\U9c9c\U82b1\U5e97";
     "surplus_days" = 117;
     
     */

}


-(void)MaekShaeWithBlocks:(void (^)(NSString *))Blocks{
  
    ShareBlockss =[Blocks copy];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sharactionssss:(id)sender {
    // 实现分享     分享获取  收益 
    
    
    self.shareImage.image = [UIImage imageNamed:@"app_fenxiangxin_activate"];
  NSString * str =@"分享";
    ShareBlockss(str );

}
@end

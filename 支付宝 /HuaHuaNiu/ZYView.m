//
//  ZYView.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-4.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ZYView.h"
#import "UIImageView+WebCache.h"
@implementation ZYView
-(void)makeDataWithModel:(AlexModel *)model{
    self.IntrLabel.textAlignment =NSTextAlignmentCenter;
    self.LongLabel.text =@"";
    
    self.IntrLabel.text =[NSString stringWithFormat:@"￥%@",model.samePrice];
    self.LongLabel.text =[NSString stringWithFormat:@"%@",model.sameTitle];
    
    
    NSURL  *urlStr =[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,model.sameLogo]];
    [self.smallImage sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:@"default"]];
    IDStr  =model.sameId;
    /*
     adfloor = 6;
     adtype = 3;
     advalue = 584;   id
     area = 0;
     catename = "";
     flowers = 0;
     intro = "";
     link = "";
     logo = "data/files/mall/appadv/30.png";
     othername = "";
     "partner_id" = 30;
     "position_id" = 2;
     price = "";
     "sort_order" = 0;
     "store_id" = 0;
     title = 62;
     
     */

}
-(void)makeDataWithDic:(NSDictionary *)dic{

    self.IntrLabel.textAlignment =NSTextAlignmentCenter;
    self.LongLabel.text =@"";
    self.IntrLabel.text =[NSString stringWithFormat:@"￥%@",[dic objectForKey:@"price"]];
    self.LongLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
 
   
    NSURL  *urlStr =[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"logo"]]];
    [self.smallImage sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:@"default"]];
    IDStr  =[dic objectForKey:@"advalue"];
/*
 adfloor = 6;
 adtype = 3;
 advalue = 584;   id
 area = 0;
 catename = "";
 flowers = 0;
 intro = "";
 link = "";
 logo = "data/files/mall/appadv/30.png";
 othername = "";
 "partner_id" = 30;
 "position_id" = 2;
 price = "";
 "sort_order" = 0;
 "store_id" = 0;
 title = 62;

 */


}
-(void)makeDataWithStoreDic:(NSDictionary *)dic{

    self.IntrLabel.textAlignment =NSTextAlignmentCenter;
    self.IntrLabel.text =[NSString stringWithFormat:@"￥%@",[dic objectForKey:@"price"]];
    self.LongLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];
//    if (self.LongLabel.text.length==6) {
//    }
    
    NSURL  *urlStr =[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"default_image"]]];
    [self.smallImage sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:@"default"]];
    IDStr  =[dic objectForKey:@"goods_id"];
}
- (IBAction)PushAction:(id)sender {

PushChanPinBlocks(IDStr);
}

-(void)ViewPushBlocks:(void (^)(NSString *))Blocks{
    PushChanPinBlocks =[Blocks copy];
 
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

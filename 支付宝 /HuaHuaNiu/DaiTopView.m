//
//  DaiTopView.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-19.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "DaiTopView.h"
#import "UIImageView+WebCache.h"

@implementation DaiTopView

-(void)ViewMakeDAIRWithDIc:(NSDictionary *)dic{
    //(@"%@",dic);
    [self.logoIV.layer setMasksToBounds:YES];
    [self.logoIV.layer setCornerRadius:20];//设置矩形四个圆角半径
    [self.logoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl, [ dic objectForKey:@"logo"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    self.topLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"voucher_name"]];
    self.MianZhiLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]];
    float numbr =[[dic objectForKey:@"surplus_days"]floatValue];
    if (numbr < 0) {
       self.GuoQiLabel.text =@"已过期";
    }
    else{
     self.GuoQiLabel.text =[NSString stringWithFormat:@"还有 %@ 天过期，逾期失效",[dic objectForKey:@"surplus_days"]];
    }
    
    self.ChiYouLabel.text=[NSString stringWithFormat:@"已有%@人持有",[dic objectForKey:@"surplus"]];
    
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

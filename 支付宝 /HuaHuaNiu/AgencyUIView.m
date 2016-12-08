//
//  AgencyUIView.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "AgencyUIView.h"
#import "UIImageView+WebCache.h"
@implementation AgencyUIView

-(void)makeDataWithDic:(NSDictionary *)Dic{
   
    self.NameLabel.text =[Dic objectForKey:@"store_name"];
    self.SloganLabel.text=[Dic objectForKey:@"slogan"];
    
    
    [self.ImageIma sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[Dic objectForKey:@"store_logo"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    float a =[[Dic objectForKey:@"distance"]floatValue];

    if (a < 1000) {
        self.DistanceLabel.text=@"附近";
    }
    else {
        
        self.DistanceLabel.text =[NSString stringWithFormat:@"%.1fkm",a/1000];
    }


}
@end

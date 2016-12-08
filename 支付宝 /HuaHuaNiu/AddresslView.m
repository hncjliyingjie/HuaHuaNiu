//
//  AddresslView.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-5-11.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "AddresslView.h"

@implementation AddresslView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)ViewmakedataWithdi:(NSDictionary *)dic{
    if (dic ==nil) {
        self.hiddenView.hidden =NO;
    }else{
        self.hiddenView.hidden =YES;
    self.NameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"consignee"]];
    self.AddressLabel.text =[NSString stringWithFormat:@"%@ %@",[dic objectForKey:@"region_name"],[dic objectForKey:@"address"]];
    self.PhoneLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"mobile"]];
    }

}

@end

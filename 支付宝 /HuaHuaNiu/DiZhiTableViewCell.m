//
//  DiZhiTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-24.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "DiZhiTableViewCell.h"

@implementation DiZhiTableViewCell

- (void)awakeFromNib {
    self.Bjbtn.hidden = YES;
    self.BJimag.hidden = YES;
    
    
    //self.scBtn.hidden = YES;
    self.scimag.hidden = YES;
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dizhiCellWithDic:(NSDictionary *)Dic{
    XiuGaidic =[[NSDictionary alloc]initWithDictionary:Dic];
/*
 addr_id": "194",
 "user_id": "0",
 "consignee": "邢行",
 "region_id": "56685",
 "region_name": "山西 临汾 吉县",
 "address": "积极多",
 "zipcode": "586523",
 "phone_tel": "5652865245",
 "phone_mob": "13460208979",
 "user_address_ll": "36.158677317484,110.7281619704",
 "state": "0"
 
 */
    self.MoreBtn.selected =NO;
    NSString * str =[NSString stringWithFormat:@"%@",[Dic objectForKey:@"status"]];
    if ([str isEqualToString:@"1"]) {
        self.MoreBtn.selected = YES;
    }
  
    self.NameLabel.text =[Dic objectForKey:@"consignee"];
    self.PhoneLabel.text =[Dic objectForKey:@"phone_mob"];
    self.DiQuLabel.text =[Dic objectForKey:@"region_name"];
    self.YOuBian.text =[Dic objectForKey:@"zipcode"];
    self.AddresssLabel.text =[Dic objectForKey:@"address"];
    adressID   =[NSString stringWithFormat:@"%@",[Dic objectForKey:@"address_id"]];
}



// 默认
- (IBAction)MorenAction:(id)sender {
    //每次修改重新请求数据  选中状态 根据返回数据来定

    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    self.MoreBtn.selected = !self.MoreBtn.selected;
    [dic setValue:adressID forKey:@"chongxinJZ"];
    qiuqiuBlocks(dic);
}
//删除
- (IBAction)DeletAction:(id)sender {
   
    deleMessageBlocks(XiuGaidic);
}

//编辑
- (IBAction)BianJiAction:(id)sender {
   // NSDictionary *dic =[[NSDictionary alloc]init];
    ChangeMessAgeBlocks(XiuGaidic);
    
}
-(void)qingqiushuuBlocks:(void (^)(NSDictionary *))Blocks{
    qiuqiuBlocks =[Blocks copy];

}
-(void)deleBlocks:(void (^)(NSDictionary *))Blocks{
    deleMessageBlocks =[Blocks copy];
}
-(void)ChangeBlocks:(void (^)(NSDictionary *))Blocks{
    ChangeMessAgeBlocks =[Blocks copy];
}
@end

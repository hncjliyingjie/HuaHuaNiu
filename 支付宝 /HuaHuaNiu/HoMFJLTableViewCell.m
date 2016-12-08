//
//  HoMFJLTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-30.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "HoMFJLTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HoMFJLTableViewCell

- (void)awakeFromNib {
    // Initialization code
    MUArr =[[NSMutableArray alloc]init];
    
    self.UserBtn.layer.cornerRadius = 3;
}

-(void)honcellMakeWIthDIc:(NSDictionary *)dic{
    self.UserBtn.hidden = NO;
    
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"logo"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    
    
    self.NameLae.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"goods_name"]];
    

   self.TimeLabe.text =[dic objectForKey:@"end_date"];

    NSString *str =[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
    
    if ( [str isEqualToString:@"0"]) {
        self.UserBtn.selected =NO;
    }
    else{
    self.UserBtn.selected =YES;
    }
    
    strId =[dic objectForKey:@"free_code"];
    self.concenetL.text = [NSString stringWithFormat:@"编号:%@",strId];
/*
 description = "";
 "expiration_time" = 0;
 logo = "";
 state = 1;
 surplus = "-1429434338";
 "vd_code" = WsSd0GbT;
 "vd_id" = 1;
 vname = 10;
 "voucher_id" = 23;
 
 */




}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)BtnSelesecACtion:(id)sender {
    
   // self.UserBtn.selected = !self.UserBtn.selected;
}
//-(void)DeleBlocks:(void (^)(NSString *))Blocks{
//    DeleBlocks=[Blocks copy];
//}
- (IBAction)deleBtnActionss:(id)sender {
//    self.deleteBtn.selected = !self.deleteBtn.selected;
//    if(self.deleteBtn.selected){
//   // 添加到数组里面
//        //(@"%@",strId);
//        [MUArr addObject:strId];
//        DeleBlocks(MUArr);
//    }else{
//   // 从数组里面删除
//        [MUArr removeObject:strId];
//        DeleBlocks(MUArr);
//}
//    //(@"%@",MUArr);
}
@end

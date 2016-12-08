//
//  SCStoreTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "SCStoreTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation SCStoreTableViewCell

- (void)awakeFromNib {
    self.DeleBtn.hidden = YES;
    // Initialization code
}
-(void)makeWithDic:(NSDictionary *)Dic{

    [self.IconImageView  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[Dic objectForKey:@"store_logo"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    self.NameLabel.text =[Dic objectForKey:@"store_name"];
    //self.FenleiLabel.text =[Dic objectForKey:@"fenlei"];
    NSString * str =[Dic objectForKey:@"voucherstate"];
    
    if ( [str isEqualToString:@"1" ]) {
        self.QuanView.hidden = NO;
    }
    else{
    self.QuanView.hidden = YES;
    }
    
    
   NSString * BD=[NSString stringWithFormat:@"%@",[Dic objectForKey:@"bind_status"]] ;
    //   // 判断绑定的 状态  0 未绑定 1 寻找代言人 2 已绑定
    if ([BD isEqualToString:@"0"]) {
        self.FenleiLabel.text =@"暂无代言人";
    }
    else if ([BD isEqualToString:@"1"]) {
        self.FenleiLabel.text =@"寻找代言人";
    }
    else if ([BD isEqualToString:@"2"]) {
        self.FenleiLabel.text =@"已有代言人";
    }
    

    
    //  more 全左边左边相对于 起始点的距离
   // CGFloat more =  self.NameLabel.text.length *15 -(ConentViewWidth-20-180);
//  CGFloat more =  ConentViewWidth  -180 - self.NameLabel.text.length*15;
//    self.QuanView.frame=CGRectMake( 199 + more , 17, 15, 15);
//    if (more < 10) {
//     self.QuanView.frame=CGRectMake(160 - more , 35, 15, 15);
//    }

    
    
  



}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)deleBee:(void (^)())Blocks{
    deleBlocks =[Blocks copy];
}
- (IBAction)DeleAction:(id)sender {
 deleBlocks();
}
@end

//
//  HistoryTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation HistoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)cellHistoryWithDic:(NSDictionary *)dic{
 // 根据参数判断是已经分享还是未分享
    self.shaeBtnss.hidden = YES;
    self.XinImageView.hidden = YES;
    
    [self.IconImage  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"store_logo"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    
    self.TimerLabel.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"start_date"]];
    self.StoreName.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"store_name"]];
    self.MoneyLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"money"]];

    /*
 "bind_days" = 0;
 "bind_endtime" = 0;
 "bind_time" = 1425722318;
 bsid = 2;
 money = 0;
 "store_id" = 232;
 "store_logo" = "/data/files/mall/storelogo/140428074153210991.jpg";
 "store_name" = "\U8d2d\U798f\U8d85\U5e02";

 */


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)shareUserBlock:(void (^)(NSString *))Blocks{
    ShareBlock =[Blocks copy];
}

-(void)CelldeleteBlocks:(void (^)(NSDictionary *))Blocks{
    DeleteBlocks  =[Blocks copy];

}

// 分享
- (IBAction)SharAvtion:(id)sender {
    ShareBlock(@"sdfs");
    
   }
// 删除
- (IBAction)DelegateHostoryAction:(id)sender {
    NSDictionary *dic =[[NSDictionary alloc]init];
    DeleteBlocks(dic);
    self.deldegateBtn.selected = !self.deldegateBtn.selected;
}
@end

//
//  MYCardTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-23.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "MYCardTableViewCell.h"
#import "AFNetworking.h"
@implementation MYCardTableViewCell

- (void)awakeFromNib {
    
    self.DeleActionActions.hidden = YES;
    // Initialization code
}
-(void)MYcellMakeWithDic:(NSDictionary *)dic{

    self.NameLabel.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    
    NSString * str =[NSString stringWithFormat:@"%@",[dic objectForKey:@"card_number"]];
    
    self.CardLabel.text =str;
    CardStr =[NSString stringWithFormat:@"%@",[dic objectForKey:@"bankcard_id"]];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 删除银行卡
- (IBAction)ChangeCardAction:(id)sender {
    
    
    NSString *ShouY = [NSString stringWithFormat:DELEYHK,CardStr,self.CardLabel.text];
    ShouY =[ShouY stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager GET:ShouY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DeleBlack();
        
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    UIAlertView * failAlView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [failAlView show];
        //(@"cook load failed ,%@",error);
    }];
    
}
-(void)deleBlockss:(void (^)())Blocks{

    DeleBlack =[Blocks copy];

}
@end

//
//  ProductSTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-25.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "ProductSTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ProductSTableViewCell

- (void)awakeFromNib {
    self.DeleBtn.hidden = YES;
    // Initialization code
}
/*
 
 @property (weak, nonatomic) IBOutlet UIImageView *IconImageView;
 @property (weak, nonatomic) IBOutlet UIImageView *HuodongImageVIew;
 @property (weak, nonatomic) IBOutlet UILabel *NameLabel;
 @property (weak, nonatomic) IBOutlet UILabel *PriceLabel;
 @property (weak, nonatomic) IBOutlet UILabel *ShouchuLabel;
 @property (weak, nonatomic) IBOutlet UILabel *AddressLabel;
 

 */
-(void)makeProductDic:(NSDictionary *)Dic{
    
    
    /*
     "add_time" = 1427904356;
     "default_image" = "data/files/store_413/goods_143/small_201504011532232656.jpg";
     fee = 0;
     "goods_id" = 881;
     "goods_name" = "\U6001\U7684GIF\U683c\U5f0f\U56fe\U7247\Uff0c\U4e0d\U652f";
     price = "200.00";
     sales = 0;

     */
    NSString * str =[NSString stringWithFormat:@"%@",[Dic objectForKey:@"fee"]];
    
    if ( [str isEqualToString:@"0"]) {
        self.HuodongImageVIew.hidden = NO;
    }
    else{
     self.HuodongImageVIew.hidden = YES;
       
    
    }
    
    [self.IconImageView  sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[Dic objectForKey:@"default_image"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    self.NameLabel.text =[Dic objectForKey:@"goods_name"];
    self.PriceLabel.text = [NSString stringWithFormat:@"%@元",[Dic objectForKey:@"price"]];
   self.Numberlabel.text =[NSString stringWithFormat:@"已售出%@件",[Dic objectForKey:@"selled_num"]];
    
//    NSString * addstr=[NSString stringWithFormat:@"%@",[Dic objectForKey:@"address"]];
//     //(@"%@  add",addstr);
//    if ([addstr isEqualToString:@"(null)"]) {
//
//        //(@"addre  ==%d = %@  add",addstr.length,addstr);
//    }
//    
//    else{
//    }
    NSString * addstr=[NSString stringWithFormat:@"%@",[Dic objectForKey:@"store_name"]];

    //company_address
    self.AddressLabel.text =addstr;
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)deleBee:(void (^)())Blocks{
    deleBlockss =[Blocks copy];
}

- (IBAction)DeleActions:(id)sender {
    deleBlockss();
}
@end

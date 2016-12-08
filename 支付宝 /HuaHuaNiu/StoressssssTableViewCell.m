//
//  StoressssssTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-14.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "StoressssssTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface StoressssssTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *juanMargin;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *juanWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *duiWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *duiMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mianWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mianMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pinWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pinMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhuanWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhuanMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shiWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shiMargin;


@end

@implementation StoressssssTableViewCell

- (void)awakeFromNib {
// Initialization code
}


-(void)MadddWithDic:(NSDictionary *)dic{
    
    // 代金券
    
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,[dic objectForKey:@"store_logo"]]] placeholderImage:[UIImage imageNamed:@"default"]];
    self.NameLabel .text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"store_name"]];
    NSString * sss  =[ NSString stringWithFormat:@"%@km",[dic objectForKey:@"distance"]];

    self.DiZhiLabel.text =sss;

    NSString * Quaser =[NSString stringWithFormat:@"%@",[dic objectForKey:@"voucher_status"]];

    if ([Quaser isEqualToString:@"1"]) {
        self.QuanImageView.hidden =NO;
    }
    else{
        self.QuanImageView.hidden = YES;
    }
    
    self.FenleiLabel.hidden = YES;
    // self.FenleiLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cate_name"]];
    str= [NSString stringWithFormat:@"%@",[dic objectForKey:@"bind_status"]];
    //   // 判断绑定的 状态  0 未绑定 1 寻找代言人 2 已绑定
    if ([str isEqualToString:@"0"]) {
        self.DaiYanLabel.text =@"暂无代言人";
    }
    else if ([str isEqualToString:@"1"]) {
        self.DaiYanLabel.text =@"寻找代言人";
        
    }
    
    else if ([str isEqualToString:@"2"]) {
        self.DaiYanLabel.text =@"已有代言人";
        
    }
    
    /*
     "address_ll" = "";
     bindstate = 1;
     "store_id" = 425;
     "store_logo" = "<null>";
     "store_name" = 124124;
     
     */
    
}


-(void)makeCellWithModel:(WanShangModel *)model{
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,model.storeLogo]] placeholderImage:[UIImage imageNamed:@"default"]];
    self.NameLabel.text =model.storeName;
    NSString * sss  =model.storeDistance;

    self.DiZhiLabel.text =[NSString stringWithFormat:@"%@ km",sss];
    NSLog(@"%@",[NSString stringWithFormat:@"%@ km",sss]);
    NSString * Quaser =[NSString stringWithFormat:@"%@",model.storeVoucher_status];
    NSString * Quaser1 =[NSString stringWithFormat:@"%@",model.storeHas_change];
    NSString * Quaser2 =[NSString stringWithFormat:@"%@",model.storeHas_free];
    NSString * Quaser3 =[NSString stringWithFormat:@"%@",model.storeHas_join];
    NSString * Quaser4 =[NSString stringWithFormat:@"%@",model.storeHas_prize];
    NSString * Quaser5 =[NSString stringWithFormat:@"%@",model.storeHas_video];

    if ([Quaser isEqualToString:@"1"]) {
        self.QuanImageView.hidden =NO;
        self.juanWidth.constant = 15;
        self.juanMargin.constant = 5;
    }
    else{
        self.QuanImageView.hidden = YES;
        self.juanWidth.constant = 0;
        self.juanMargin.constant = 0;
    }
    if ([Quaser1 isEqualToString:@"1"]) {
        self.DuiImageView.hidden =NO;
        self.duiMargin.constant = 5;
        self.duiWidth.constant = 15;
    }
    else{
        self.DuiImageView.hidden = YES;
        self.duiMargin.constant = 0;
        self.duiWidth.constant = 0;
    }
    if ([Quaser2 isEqualToString:@"1"]) {
        self.MianImageView.hidden =NO;
        self.mianMargin.constant = 5;
        self.mianWidth.constant = 15;
    }
    else{
        self.MianImageView.hidden = YES;
        self.mianMargin.constant = 0;
        self.mianWidth.constant = 0;
    }
    if ([Quaser3 isEqualToString:@"1"]) {
        self.ZhaoImageView.hidden =NO;
        self.pinMargin.constant = 5;
        self.pinWidth.constant = 15;
    }
    else{
        self.ZhaoImageView.hidden = YES;
        self.pinMargin.constant = 0;
        self.pinWidth.constant = 0;
    }
    if ([Quaser4 isEqualToString:@"1"]) {
        self.KanImageView.hidden =NO;
        self.zhuanMargin.constant = 5;
        self.zhuanWidth.constant = 15;
    }
    else{
        self.KanImageView.hidden = YES;
        self.zhuanMargin.constant = 0;
        self.zhuanWidth.constant = 0;
    }
    if ([Quaser5 isEqualToString:@"1"]) {
        self.ShiImageView.hidden =NO;
    }
    else{
        self.ShiImageView.hidden = YES;
    }

    
    self.FenleiLabel.hidden = YES;
    str=model.storeBaind;
    //   // 判断绑定的 状态  0 未绑定 1 寻找代言人 2 已绑定
    if ([str isEqualToString:@"0"]) {
        self.DaiYanLabel.text =@"暂无代言人";
    }
    else if ([str isEqualToString:@"1"]) {
        self.DaiYanLabel.text =@"寻找代言人";
        
    }
    else if ([str isEqualToString:@"2"]) {
        
        self.DaiYanLabel.text =@"已有代言人";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

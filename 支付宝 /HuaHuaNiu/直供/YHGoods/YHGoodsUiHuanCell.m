//
//  YHGoodsUiHuanCell.m
//  花花牛
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YHGoodsUiHuanCell.h"
#import "UIImageView+WebCache.h"

@interface YHGoodsUiHuanCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *changeImage;
@property (weak, nonatomic) IBOutlet UIImageView *changeImage2;
@property (weak, nonatomic) IBOutlet UILabel *yinYuan;
@property (weak, nonatomic) IBOutlet UIImageView *chaKanimage;

@property (weak, nonatomic) IBOutlet UIImageView *dingweiImage;
@property (weak, nonatomic) IBOutlet UILabel *dingweiLable;
@property (weak, nonatomic) IBOutlet UILabel *chakanLable;

@end

@implementation YHGoodsUiHuanCell

- (void)setDuiHuanmodel:(YHGoodsModel *)DuiHuanmodel{
    _DuiHuanmodel = DuiHuanmodel;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",DuiHuanmodel.default_image]]];
    
    self.name.text = DuiHuanmodel.goods_name;
    NSString *change_type= [NSString stringWithFormat:@"%@",DuiHuanmodel.change_type];
    //兑换方式：0：全部 1：现场 2：邮寄
    if ([change_type isEqualToString:@"2"] ){
        
        self.changeImage.image = [UIImage imageNamed:@"邮"];
        self.changeImage.hidden = NO;
        self.changeImage2.hidden = YES;
    }else if ([change_type isEqualToString:@"1"]) {
        self.changeImage.image = [UIImage imageNamed:@"现金"];
        self.changeImage.hidden = NO;
        self.changeImage2.hidden = YES;
    }else if ([change_type isEqualToString:@"0"]) {
        self.changeImage.image = [UIImage imageNamed:@"现金"];
        self.changeImage2.image = [UIImage imageNamed:@"邮"];
        self.changeImage.hidden = NO;
        self.changeImage2.hidden = NO;
    }else{
        self.changeImage.hidden = YES;
        self.changeImage2.hidden = YES;
    }
    
    self.yinYuan.text = [NSString stringWithFormat:@"%@",DuiHuanmodel.sale_integral];
    self.dingweiLable.text = [NSString stringWithFormat:@"%.2f",[DuiHuanmodel.distance floatValue]];
    self.chakanLable.text = [NSString stringWithFormat:@"%@",DuiHuanmodel.has_lookers];
    

}

@end

//
//  YHGoodsCollectionCell.m
//  花花牛
//
//  Created by mac on 16/4/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YHGoodsCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface YHGoodsCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *numberLable;

@end

@implementation YHGoodsCollectionCell

- (void)setModel:(YHGoodsModel *)model{
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://daiyancheng.cn/%@",model.default_image]]];
    self.backgroundColor = [UIColor whiteColor];
    self.nameLable.text = model.goods_name;
    self.priceLable.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    NSDictionary *attribtDic2 = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价:%@",model.original_price] attributes:attribtDic2];
    self.numberLable.attributedText = attribtStr2;

}


@end

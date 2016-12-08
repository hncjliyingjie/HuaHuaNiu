//
//  DYTableViewCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/4.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "DYTableViewCell.h"

@implementation DYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    [self.collectionImageView addGestureRecognizer:tap];
    // Initialization code
}
-(void)setCellWithData:(ZYTModel *)model{
    
    _nameLbl.text=model.name;
    _friendLbl.text=[NSString stringWithFormat:@"%@",model.friendNumber];
    _priceLbl.text=[NSString stringWithFormat:@"%@",model.price];
    _collectLbl.text=[NSString stringWithFormat:@"%@",model.collect];
    
    if (model.img==nil) {
        _imgView.image=[UIImage imageNamed:@"default"];
    }else{
        _imgView.image=model.img;
    }

}

- (void)tapImage:(UITapGestureRecognizer *)tap {
    
    NSInteger collect = [self.collectLbl.text integerValue];
    self.collectLbl.text = [NSString stringWithFormat:@"%ld", collect];
    self.collectBlock();
    KMyLog(@"收藏个数%@", self.collectLbl.text);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

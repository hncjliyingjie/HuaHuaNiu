//
//  RecommendTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-13.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "RecommendTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation RecommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)coremmondcellmakeWithModel:(bindStoreModel *)model{
    self.StoreName.text =model.store_name;
    self.TimeLabel.text =model.bind_days;
    self.FlowerLabel.text =model.bind_need_flower;
    StoreID  =model.store_id;
    [self.IconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,model.store_logo]] placeholderImage:[UIImage imageNamed:@"default"]];
}



-(void)TishiBlocksShow:(void (^)(NSString *))Blocks{
    TishiBlocks =[Blocks copy];
}
- (IBAction)BangDingAction:(id)sender {
    TishiBlocks(StoreID);
}
@end

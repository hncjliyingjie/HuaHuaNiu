//
//  HHHeaderView.m
//  HHHorizontalPagingView
//
//  Created by Huanhoo on 15/7/16.
//  Copyright (c) 2015年 Huanhoo. All rights reserved.
//

#import "HHHeaderView.h"
#import "Masonry.h"
#import "ZYModel.h"
@implementation HHHeaderView

+ (HHHeaderView *)headerView {
    HHHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"HHHeaderView" owner:self options:nil][0];
  
    
        return headerView;
}

- (void)showViewWithModel:(ZYModel *)model {
    self.ditieName.text = [NSString stringWithFormat:@"%@", model.name];
    self.miaoshuLbl.text = [NSString stringWithFormat:@"%@", model.profiles];
    self.priceLbl.text=[NSString stringWithFormat:@"%@",model.price];
    self.loctionLbl.text=[NSString stringWithFormat:@"%@%@%@",model.province,model.city,model.address];
    self.coverNumberLbl.text= [NSString stringWithFormat:@"%@",model.cover_num];
    self.timeLbl.text=[NSString stringWithFormat:@"%@——————%@",model.start_time,model.end_time];
    
    self.typeLbl.text=[NSString stringWithFormat:@"户外"];
    self.guigeLbl.text=[NSString stringWithFormat:@"%@cm*%@cm",model.width,model.height];
    self.dyrLbl.text= [NSString stringWithFormat:@"恭喜%@成为代言人",model.nick_name];
    self.companyNameLbl.text = [NSString stringWithFormat:@"%@", model.company_name];
    NSURL *headImaURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", DYUrl, model.iconURLStr]];
    [self.headImg sd_setImageWithURL:headImaURL placeholderImage:[UIImage imageNamed:@"shoucang"]];
    
    //简介自适应高度
    self.miaoshuLbl.numberOfLines = 0;
    
    self.miaoshuLbl.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [self.miaoshuLbl sizeThatFits:CGSizeMake(self.miaoshuLbl.frame.size.width, MAXFLOAT)];
    
    self.profielsHeight.constant=size.height;
    
    }

@end

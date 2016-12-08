//
//  MianFeiTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-30.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "MianFeiTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TrueModel.h"
@implementation MianFeiTableViewCell

- (void)awakeFromNib {
    self.ConcentLabel.textColor =[UIColor colorWithRed:253/255.0 green:138/255.0 blue:38/255.0 alpha:1];
}

-(void)makeCellWithModel:(TrueModel *)model{
    [self.ImageVeiw sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:IMaUrl,model.default_image]] placeholderImage:[UIImage imageNamed:@"default"]];
    self.NameLabel.text =model.goods_name;
    NSString *str =model.end_date;
    // //(@"%d",str.length);
    if( str.length == 0 ){
        self.ConcentLabel.hidden =YES;
    }
    else if ( str.length < 9) {
        self.ConcentLabel.frame =CGRectMake(self.ConcentLabel.frame.origin.x, self.ConcentLabel.frame.origin.y +15,self.ConcentLabel.frame.size.width ,self.ConcentLabel.frame.size.height/2 );
    }
    else  {
        self.ConcentLabel.frame =CGRectMake(129,35,112,34);
    }
    
    self.ConcentLabel.text =[NSString stringWithFormat:@"结束日期: %@",str];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)qianggouAction:(id)sender {
}
@end

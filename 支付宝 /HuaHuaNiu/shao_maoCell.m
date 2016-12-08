//
//  shao_maoCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/29.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "shao_maoCell.h"

@implementation shao_maoCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.frame.size.width,30)];
        
        _label.font=[UIFont systemFontOfSize:13];
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(5, 30, self.frame.size.width-10, 0.5)];
        lineView.backgroundColor=[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
        
        _img=[[UIImageView alloc]initWithFrame:CGRectMake(30, 35, 30, 60)];
        
        
        [self.contentView addSubview:_label];
        [self.contentView addSubview:lineView];
        [self.contentView addSubview:_img];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

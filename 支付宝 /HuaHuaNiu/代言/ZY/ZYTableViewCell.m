//
//  ZYTableViewCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/7.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZYTableViewCell.h"

@implementation ZYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setCellWithZYData:(ZY_DataModel *)model{
    
    _plsLbl.text=[NSString stringWithFormat:@"%@评论",model.pinglunStr];
    _liulanLbl.text=[NSString stringWithFormat:@"%@",model.liulanStr];
    _frofiesLbl.text=model.filesStr;
    _nameTitle.text=model.nameStr;
    
    if (model.headImg == nil) {
        _img.image=[UIImage imageNamed:@"default"];
    }else{
        _img.image=model.headImg;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

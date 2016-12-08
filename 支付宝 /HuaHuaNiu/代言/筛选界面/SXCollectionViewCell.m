//
//  SXCollectionViewCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/27.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "SXCollectionViewCell.h"

@implementation SXCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:YES];
    if (selected) {
//        self.label.backgroundColor=[UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1];
        self.layer.borderColor = [UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1].CGColor;
        self.layer.borderWidth = 1.0f;
        self.label.textColor = [UIColor colorWithRed:0.047 green:0.364 blue:0.663 alpha:1];
        
    }else{
    
//        self.label.backgroundColor=[UIColor whiteColor];
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1.0f;
         self.label.textColor = [UIColor grayColor];
    }
    

}
@end

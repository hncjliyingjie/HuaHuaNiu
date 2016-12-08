//
//  NearlySTableViewCell.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-4-1.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "NearlySTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation NearlySTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)makeCellWithModel:(AlexModel *)model{
    NSURL *urlStr= [NSURL URLWithString:[NSString stringWithFormat:IMaUrl,model.nearlogo]];
    [self.IconImage sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:@"default"]];
    
    self.NameLabel.text =model.nearTitle;
    self.NameLabel.textAlignment = YES;
    NSString * bangdingstr =model.nearStatus;
        //无代言人 0没有 1 寻找中 2有代言人
    if ( [bangdingstr isEqualToString:@"0"]) {
//        self.DaiYanlabel.text =@"暂无代言人";
    }
    else if( [bangdingstr isEqualToString:@"1"]){
//        self.DaiYanlabel.text =@"寻找代言人";
    }
    else{
//        self.DaiYanlabel.text =@"已有代言人";
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ZTMoreCell.m
//  HuaHuaNiu
//
//  Created by mac on 16/11/6.
//  Copyright © 2016年 张燕. All rights reserved.
//

#import "ZTMoreCell.h"

@implementation ZTMoreCell

- (void)showDataWithModel:(ZMTDetailModel *)model {
    self.scoreLabel.text = [NSString stringWithFormat:@"%@", model.score];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", model.finish_time];
    self.feedbackLabel.text = [NSString stringWithFormat:@"%@", model.feedback];
    NSString *url = [NSString stringWithFormat:@"%@/%@", DYUrl, model.head];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"Default"]];
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

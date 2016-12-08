//
//  SmaView.m
//  HuaHuaNiu
//
//  Created by 张燕 on 15-3-2.
//  Copyright (c) 2015年 张燕. All rights reserved.
//

#import "SmaView.h"

@implementation SmaView
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        
    }
    return  self;
}
-(void)setWithImaStr:(NSString *)imaStr AndLabelStr:(NSString *)LabelStr WoDeLable:(NSString *)woDe {
    self.IconImage.image =[UIImage imageNamed:imaStr];
    self.IconLabel.text = LabelStr;
    
    if ([woDe isEqualToString:@"0"]) {
        self.Label.hidden = YES;
    }else {
        self.Label.hidden = NO;
    self.Label.text=woDe;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
